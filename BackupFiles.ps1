[void][System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint")

#SharePoint variables
$SiteUrl = "http://SiteUrl"
$WebUrl = "WebUrl"
$LibraryName = "ListName"

#Save Path
$SavePath = "E:\ListBackup20200226"

#Get SPSite
$site= New-Object Microsoft.SharePoint.SPSite($SiteUrl)

#Get SPWeb
$Web = $site.OpenWeb($WebUrl)

#Get SPList
$List = $Web.Lists[$LibraryName]

#Loop SPListItem. If SPFolder, skip the item
foreach ($ListItem in $List.Items){
    #Set SavePath
    $SaveFolder = $SavePath + "\" + $ListItem.ID 

    #Check if SavePath exists already. If not, create SavePath
    if (!(Test-Path -path $SaveFolder)){?? 
        New-Item $SaveFolder -type directory
    }

    #Get all SPAttachment
    $AttachmentsColl = $ListItem.Attachments

    #Loop all SPAttachment
    foreach ($Attachment in $AttachmentsColl){
        #Get attachment
        $file = $web.GetFile($listItem.Attachments.UrlPrefix + $Attachment)
        $bytes = $file.OpenBinary()

        #Save attachment
        $FilePath = $SaveFolder + " \" + $Attachment
        $fs = new-object System.IO.FileStream($FilePath, "OpenOrCreate")
        $fs.Write($bytes, 0 , $bytes.Length)
        $fs.Close()
    }
}