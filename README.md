# OPUS-Upload-
A script written in Ruby, Selenium, and bash. Used for the automatic uploading and downloading of GPS Data to OPUS.
  ____  _____  _    _  _____   _____            _ _   _                
 / __ \|  __ \| |  | |/ ____| |  __ \          | | | (_)               
| |  | | |__) | |  | | (___   | |__) |___  __ _| | |_ _ _ __ ___   ___ 
| |  | |  ___/| |  | |\___ \  |  _  // _ \/ _` | | __| | '_ ` _ \ / _ \
| |__| | |    | |__| |____) | | | \ \  __/ (_| | | |_| | | | | | |  __/
 \____/|_|     \____/|_____/  |_|  \_\___|\__,_|_|\__|_|_| |_| |_|\___|
                                                                       
                                                                       
  _____                 _               
 / ____|               | |              
| |  __ _ __ __ _ _ __ | |__   ___ _ __ 
| | |_ | '__/ _` | '_ \| '_ \ / _ \ '__|
| |__| | | | (_| | |_) | | | |  __/ |   
 \_____|_|  \__,_| .__/|_| |_|\___|_|   
                 | |                    
                 |_|                    
-----------------------------------------------------------------------
Copyright 2011 Francisco Hernandez <FJHernandez89@gmail.com>

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as 
published by the Free Software Foundation; either version 3 of the 
License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public 
License along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
MA 02110-1301, USA, or see <http://www.gnu.org/licenses/>.
-----------------------------------------------------------------------

1. Introduccion
   This program uses RINEX files to create graphs of GPS data in the 
X, Y, and Z using GMT. This program uses OPUS to process the data to
plot the data relative to the first file which is proccesed. The goal
of this proyect is to eventually be able to create realtime graphs of
movement from various sources. The data is recovered by a mail sever
using the ruby script and IMAP. Gmail is recomended when using this 
program.

2. Requirements 
   These are a series of scripts with various requirements:
	*Java
	*Ruby
	*Selenium gem
	*GMT
	*Firefox
	*RINEX files
3. Use 
   The main script, for realtime use, is in the main folder. It must be
opened and configured before use. This script is designed to run in 
cron and is for realtime use, however it can also be used to proccess
existing data. To process in realtime your data can arrive in the 
updata folder and run after it arrives, this script will then upload
the data and wait for an email from opus when the email arrives the
email will automatically be downloaded and placed in the downdata
folder. Then the data will be processed and placed in a Comma Separated
Values file (CSV file) and ploted using GMT. RINEX files will be moved
to the ./updata/old folder after proccessing.

4. Helper scripts for manual use
  In case you do not want realtime OPUS scripts included in the 
./scripts can be used to do the processing manually. Their use
is outlined below:

	*UploadtoOPUS_RT.sh- Used to Upload to OPUS in ALL RINEX files 
in the ./updata folder in realtime. Moves proccesed data to the "old" 
folder as well as downloads the emails. Due to waiting for emails this 
script is slow and should not be used for processing a lot of existing 
data use UploadtoOPUS instead.

	USAGE: UploadtoOPUS_RT.sh EMAIL ANT_Height (Implies server
port user and password have been set as variables from main script)

	*UploadtoOPUS.sh- Usage same as UploadtoOPUS_RT however does 
not wait for email to download. Recomends downloading email data 
manually and then processed with automatic script.

	USAGE: UploadtoOPUS_RT.sh EMAIL ANT_Height

	*UploadToOPUS.rb- Actual uploading script. Can only upload one
RINEX file per use.

	USAGE UploadToOPUS.rb EMAIL FILENAME ANT_Height

	*DownloadFromOPUS.rb- Used to wait and download e-mail from 
OPUS and can be used once per email.

	USAGE: DownloadFromOPUS.rb SERVER USER PASS PORT

	*FixEmail.sh- Used to fix and Sort email downloaded 
automatically from OPUS via RUBY script.

	USAGE: FixEmail.sh Email_Filename
	
	*Extract_Data.sh- Used to "most" of the data from the emails
that were recived. This is raw data and will be extracted in a columnar
format. This data will also be sorted by day. If you require headers 
you need to uncomment a line within the script.

	USAGE: Extract_Data Email_Filename

	*XYZ_To_GMT.sh- This script is used to create a normailzed xyz
file from the extracted data. The data will be normalized in order to 
see movement of the GPS station. It will be relative always to the 
first day of the input file. This script takes a Dividend for dividing
the number from opus to set the resolution (e.g .001 for cm, 1 for m)




