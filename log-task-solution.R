# Rscript log-task-solution.R groupby datatable 0

args = commandArgs(TRUE)

library(data.table)
batch=Sys.getenv("BATCH", NA)
timestamp=as.numeric(Sys.time())
task=args[1L]
solution=args[2L]
finished=args[3L]
nodename=Sys.info()[["nodename"]]
lg = data.table(nodename=nodename, batch=batch, task=task, solution=solution, timestamp=timestamp, finished=finished)
file = "logs.csv"
fwrite(lg, file=file, append=file.exists(file), col.names=!file.exists(file))

#fread("logs.csv"
#      )[, dcast(.SD, batch+task+solution ~ finished, value.var="timestamp")
#        ][, .(batch, task, solution, start=as.POSIXct(`0`, origin="1970-01-01"), end=as.POSIXct(`1`, origin="1970-01-01"), elapsed_sec=`1`-`0`)
#          ][]
