module Loading exposing (slowThreshold)

import Process
import Task exposing (Task)


slowThreshold : Task x ()
slowThreshold =
    Process.sleep 500
