---para subir excel en formato .csv

Bulk
Insert AHCOSTOS
FROM 'F:\PRUEBAS SUBIR ARCHIVO\03PlantillaAHcostosAbril2024cierre.csv'
with (firstrow=2, fieldterminator =';', rowterminator = '\n')