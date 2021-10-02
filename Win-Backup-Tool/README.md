# Windows Backup Tool
Windows Backup Tool is a simple powershell tool to backup all current user's files

## How it works
The script will do a full backup of some directories in `C:\Users\current_user` , all paths to be backed up are defined by **$paths** array. This array can be changed for your needs.

### How to change backup paths
Go to Line 17 and change the **$paths** array.

**Ex.**
With the current array 
 
`$paths='Android','Desktop','Documents','Downloads','Giochi','Music','Programmi','Università','Utils'`

The tool will backup folders: *Android, Desktop, Documents, Downloads, Giochi, Musics, Programmi, Università, Utils*  from `C:\Users\current_user`

Folders can be changed without problems and if you need to add another folder you can just add at the same line **,'your_folder'**

The tool is compressing all the content from every folder defined above separately (**partial backup)**
After that it will compress all partials backup in only one (**full backup**) which will be the final result.

## How to run
Download the script and type by using a powershell windows

`. Win-Backup-Tool.ps1`

You can also decide to don't keep partials backup by adding **-ep** or **--exclude-partial**  argument to the command

`. Win-Backup-Tool.ps1 -ep`

`. Win-Backup-Tool.ps1 --exclude-partial`

The output is at `C:\Users\current_user\Win-Backup-Tool\` and in partial folder there will be partial backups called by the backed up folder name, while in full folder there will be the full one.
