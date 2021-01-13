
function Get-SysmonProcessTampering {
    <#
    .SYNOPSIS
        Get Sysmon Process Tampering events (Event Id 25) from a local or remote host.
    .DESCRIPTION
        Get Sysmon Process Tampering events from a local or remote host. Events can be filtered by fields.
    .EXAMPLE
        PS C:\> Get-SysmonProcessTampering | select image -Unique

        Image
        -----
        <unknown process>
        C:\Program Files\Git\cmd\git.exe
        C:\Program Files\Git\mingw64\bin\git.exe
        C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe
        C:\Program Files (x86)\Google\Chrome\Application\chrome.exe
        C:\Users\cperez\AppData\Local\Programs\Microsoft VS Code\Code.exe
        C:\Windows\System32\conhost.exe

        Get unique images for use in exclusion filter. 

    .INPUTS
        System.IO.FileInfo
    .OUTPUTS
        Sysmon.EventRecord.ProcessTamper
    #>
    [CmdletBinding(DefaultParameterSetName = 'Local')]
    param (
        # Log name for where the events are stored.
        [Parameter(Mandatory = $false,
                   ValueFromPipelineByPropertyName = $true)]
        [string]
        $LogName = 'Microsoft-Windows-Sysmon/Operational',

        # Process Id
        [Parameter(Mandatory = $false,
                   ValueFromPipelineByPropertyName = $true)]
        [string[]]
        $ProcessId,

        # Process Guid
        [Parameter(Mandatory = $false,
                   ValueFromPipelineByPropertyName = $true)]
        [string[]]
        $ProcessGuid,

        # Image of process full path.
        [Parameter(Mandatory = $false,
                   ValueFromPipelineByPropertyName = $true)]
        [string[]]
        $Image,


        # Gets events from the event logs on the specified computer. Type the NetBIOS name, an Internet Protocol (IP) address, or the fully qualified domain name of the computer.
        # The default value is the local computer.
        # To get events and event logs from remote computers, the firewall port for the event log service must be configured to allow remote access.
        [Parameter(Mandatory = $true,
                   ValueFromPipelineByPropertyName = $true,
                   ParameterSetName = 'Remote')]
        [string[]]
        $ComputerName,

        # Specifies a user account that has permission to perform this action.
        #
        # Type a user name, such as User01 or Domain01\User01. Or, enter a PSCredential object, such as one generated by the Get-Credential cmdlet. If you type a user name, you will
        # be prompted for a password. If you type only the parameter name, you will be prompted for both a user name and a password.
        [Parameter(Mandatory = $false,
                   ParameterSetName = 'Remote')]
        [Management.Automation.PSCredential]
        [Management.Automation.CredentialAttribute()]
        $Credential,

        # Specifies the maximum number of events that are returned. Enter an integer. The default is to return all the events in the logs or files.
        [Parameter(Mandatory = $false,
                   ValueFromPipelineByPropertyName = $true)]
        [int64]
        $MaxEvents,

        # Stsrttime from where to pull events.
        [Parameter(Mandatory = $false)]
        [datetime]
        $StartTime,

        # Stsrttime from where to pull events.
        [Parameter(Mandatory = $false)]
        [datetime]
        $EndTime,

        # Changes the default logic for matching fields from 'and' to 'or'.
        [Parameter(Mandatory = $false)]
        [switch]
        $ChangeLogic,

        # Changes the query action from inclusion to exclusion when fields are matched.
        [Parameter(Mandatory = $false)]
        [switch]
        $Suppress
    )

    begin {}

    process {
        Search-SysmonEvent -EventId 25 -ParamHash $MyInvocation.BoundParameters

    }

    end {}
}