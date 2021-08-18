
--Permitir que las opciones avanzadas puedan ser cambiadas.
EXEC sp_configure 'show advanced options', 1
GO
RECONFIGURE
GO
--Permitir el uso de SP XP_CMDSHELL.
EXEC sp_configure 'xp_cmdshell', 0 --PARA DESHABILITAR SE CAMBIA A 0
GO
RECONFIGURE
GO
--===================================================

USE master;  
GO  
EXEC sp_configure 'show advanced option', '1';  
RECONFIGURE WITH OVERRIDE;

EXEC sp_configure 'xp_cmdshell', 1;  
GO  
RECONFIGURE;

exec xp_cmdshell 'COPY C:\TEST\TEST.txt C:\TEST2\test2.txt';

