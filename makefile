
sync:
	#rsync -var ~/teknotes ian@ianlan:/home/ian/teknotes 
	rsync -var /home/ian/teknotes/ ian@ianlan:/home/ian/teknotes/ 
	rsync -var  ian@ianlan:/home/ian/teknotes /home/ian/

server:
	#rsync -var ~/teknotes ian@server:/home/ian/teknotes 
	rsync -var /home/ian/teknotes/ ian@server:/home/ian/teknotes/ 
	rsync -var  ian@server:/home/ian/teknotes /home/ian/

