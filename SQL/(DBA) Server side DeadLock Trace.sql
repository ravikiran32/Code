/*
DEADLOCK TRACE TSQL 
*/

-- CREATE A QUEUE
declare @rc int
declare @TraceID int
declare @maxfilesize bigint
set @maxfilesize = 1024 

/* Please replace the text InsertFileNameHere, with an appropriate
 filename prefixed by a path, e.g., c:\MyFolder\MyTrace. The .trc extension
 will be appended to the filename automatically. If you are writing from
 remote server to local drive, please use UNC path and make sure server has
 write access to your network share*/

exec @rc = sp_trace_create @TraceID output, 0, N'\\Em-appl018\itsql\Traces\EMDBL01_Deadlock', @maxfilesize, NULL 
if (@rc != 0) goto error

-- Client side File and Table cannot be scripted

-- Set the events
declare @on bit
set @on = 1
exec sp_trace_setevent @TraceID, 148, 11, @on
exec sp_trace_setevent @TraceID, 148, 51, @on
exec sp_trace_setevent @TraceID, 148, 4, @on
exec sp_trace_setevent @TraceID, 148, 12, @on
exec sp_trace_setevent @TraceID, 148, 14, @on
exec sp_trace_setevent @TraceID, 148, 26, @on
exec sp_trace_setevent @TraceID, 148, 60, @on
exec sp_trace_setevent @TraceID, 148, 64, @on
exec sp_trace_setevent @TraceID, 148, 1, @on
exec sp_trace_setevent @TraceID, 148, 41, @on
exec sp_trace_setevent @TraceID, 59, 55, @on
exec sp_trace_setevent @TraceID, 59, 32, @on
exec sp_trace_setevent @TraceID, 59, 56, @on
exec sp_trace_setevent @TraceID, 59, 64, @on
exec sp_trace_setevent @TraceID, 59, 1, @on
exec sp_trace_setevent @TraceID, 59, 21, @on
exec sp_trace_setevent @TraceID, 59, 25, @on
exec sp_trace_setevent @TraceID, 59, 41, @on
exec sp_trace_setevent @TraceID, 59, 49, @on
exec sp_trace_setevent @TraceID, 59, 57, @on
exec sp_trace_setevent @TraceID, 59, 2, @on
exec sp_trace_setevent @TraceID, 59, 14, @on
exec sp_trace_setevent @TraceID, 59, 22, @on
exec sp_trace_setevent @TraceID, 59, 26, @on
exec sp_trace_setevent @TraceID, 59, 58, @on
exec sp_trace_setevent @TraceID, 59, 3, @on
exec sp_trace_setevent @TraceID, 59, 35, @on
exec sp_trace_setevent @TraceID, 59, 51, @on
exec sp_trace_setevent @TraceID, 59, 4, @on
exec sp_trace_setevent @TraceID, 59, 12, @on
exec sp_trace_setevent @TraceID, 59, 52, @on
exec sp_trace_setevent @TraceID, 59, 60, @on


-- Set the Filters
declare @intfilter int
declare @bigintfilter bigint

-- Set the trace status to start
exec sp_trace_setstatus @TraceID, 1

-- display trace id for future references
select TraceID=@TraceID
goto finish

error: 
select ErrorCode=@rc

finish: 
go



/*
DECLARE @TraceID INT 

--SET TraceID
SELECT @TraceID = id, * FROM sys.traces


EXEC sp_trace_setstatus @TraceID, 0; ---Stop trace 
EXEC sp_trace_setstatus @TraceID, 2; ---Closes the trace file, this is required to remove the definition from the server of the trace, if you want to reuse the trace don't execute this part

EXEC sp_trace_setstatus [TraceID],1; --Use this to re-start the trace, find the TraceID from the sys.traces DMV

*/