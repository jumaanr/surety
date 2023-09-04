Get-ScheduledTask | ForEach-Object {
    $task = $_
    $taskInfo = Get-ScheduledTaskInfo -TaskName $task.TaskName
    $principal = $task.Principal
    $username = $principal.UserId
    [PSCustomObject]@{
        TaskName = $task.TaskName
        TaskPath = $task.TaskPath
        State = $taskInfo.State
        NextRunTime = $taskInfo.NextRunTime
        LastRunTime = $taskInfo.LastRunTime
        LastTaskResult = $taskInfo.LastTaskResult
        ExecutingUser = $username
    }
}
