


--Earthquake Magnitude & Depth Project

SELECT * 
FROM Earthquake;

--Number of Earthquakes 

SELECT COUNT(*) SumEarthquakes
FROM Earthquake;

--Cause of Earthquake

SELECT Cause,
       COUNT(Cause) NumCause
FROM Earthquake
	GROUP BY Cause;

--Earthquakes that fall in the Range of 5.5 TO 6.0 (May cause a lot of damage in very populated areas.)

SELECT Magnitude MagnitudeMW,
       COUNT(*) Occurences
FROM Earthquake 
WHERE Magnitude BETWEEN 5.5 AND 6.0
	GROUP BY Magnitude 
	ORDER BY Magnitude,
	         Occurences DESC;

--Earthquakes that fall in the Range of 6.1 AND 6.9

SELECT Magnitude MagnitudeMW,
       COUNT(*) Occurences
FROM Earthquake 
WHERE Magnitude BETWEEN 6.1 AND 6.9
	GROUP BY Magnitude 
	ORDER BY Magnitude,
		 Occurences DESC;

--Earthquakes that fall in the Range of 7.0 TO 7.9 (Major earthquake. Serious damage.)

SELECT Magnitude MagnitudeMW,  
       COUNT(*) Occurences
FROM Earthquake 
WHERE Magnitude BETWEEN 7.0 AND 7.9
	GROUP BY Magnitude 
	ORDER BY Magnitude,
	         Occurences DESC;

--Earthquakes that fall in the Range of 8.0 or greater (Great earthquake. Can totally destroy communities near the epicenter.)

SELECT Magnitude MagnitudeMW,
       COUNT(*) Occurences
FROM Earthquake 
WHERE Magnitude = 8.0 OR Magnitude > 8.0
	GROUP BY Magnitude 
	ORDER BY Magnitude,
		 Occurences DESC;

--Avg Depth vs Avg Magnitude, Does a lower Depth correlate with greater Magnitudes?

--Shallow Earthquakes = 0 - 70 km deep (These occur the most and tend to cause the most damage, less travel time)
--Intermediate Earthquakes = 70 -300 km deep (Does relative mild damage compared to Shallow Earthquakes)
--Deep Earthquakes = 300 - 700 km deep (Causes the least amount of damage, longer travel time)

SELECT Place,
       ROUND(AVG(Magnitude),2) AverageMagnitudeMW,
       ROUND(AVG(Depth),2) AverageDepthkm
FROM Earthquake
WHERE Magnitude = 8.0 OR Magnitude > 8.0
	GROUP BY Place
	ORDER BY AverageMagnitudeMW DESC,
		 AverageDepthkm DESC;

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

--Average Magnitude & Depth Per Each Individual Country 

SELECT DISTINCT(Place),
	       AVG(Magnitude) OVER (PARTITION BY Place) AverageMagnitudeMW,
	       AVG(Depth) OVER (PARTITION BY Place) AverageDepthkm 
FROM Earthquake;

--Average Magnitude & Depth Across Every Country as a whole 

SELECT (SELECT ROUND(AVG(Magnitude),2) FROM Earthquake) AverageMagnitudeMW,
       (SELECT ROUND(AVG(Depth),2) FROM Earthquake) AverageDepthkm
FROM Earthquake
	GROUP BY Place;

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

--Strongest Earthquakes

SELECT TOP 20 Place,
	      Cause,
	      Magnitude MagnitudeMW,
	      Depth Depthkm
FROM Earthquake
	ORDER BY Magnitude DESC,
		 Depth;

--Weakest Earthquakes 

SELECT TOP 20 Place,
	      Cause,
	      Magnitude MagnitudeMW,
	      Depth Depthkm
FROM Earthquake
	ORDER BY Magnitude,
		 Depth DESC; 

--Common Magnitude & Number of Cases 

SELECT TOP 20 Magnitude MagnitudeMW,
	      Cause,
	      COUNT(Magnitude) NumCause
FROM Earthquake
	GROUP BY Magnitude,
	         Cause
	ORDER BY NumCause DESC;

SELECT TOP 20 Depth Depthkm,
	      Cause,
	      COUNT(Magnitude) NumCause
FROM Earthquake
	GROUP BY Depth,
	         Cause
	ORDER BY NumCause DESC;

SELECT TOP 20 Magnitude MagnitudeMW,
	      Depth Depthkm,
	      Cause,
	      COUNT(Magnitude) NumCause
FROM Earthquake
	GROUP BY Magnitude,
	         Depth,
		 Cause
	ORDER BY NumCause DESC;

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

--Avg Magnitude Per Earthquake Per Place

SELECT Place,
       Cause, 
       AVG(Magnitude) OVER (PARTITION BY Place) AvgMagnitude
FROM Earthquake 
	ORDER BY AvgMagnitude DESC;

--Avg Depth Per Earthquake Per Place

SELECT Place,
       Cause, 
       AVG(Depth) OVER (PARTITION BY Place) AvgDepth
FROM Earthquake 
	ORDER BY AvgDepth DESC;


