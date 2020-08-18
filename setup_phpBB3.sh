if ! command -v docker-compose &> /dev/null
then
	echo "";
	echo "Docker is not installed!" 
	echo "https://hub.docker.com/editions/community/docker-ce-desktop-mac/"
	echo "";
	exit 1;
fi
	
read -p "Continuing will wipe everything in public/ AND any data in the mysql container. Are you sure you want to do that? [Y/n] " removepublic
if [[ $removepublic != "n" ]]; then

	if ! command -v unzip &> /dev/null; then
		echo "";
		echo "Unzip command not found. Install unzip!";
		echo "";
		exit 1;
	fi

  rm -rf public/;

  wget https://github.com/Nepaltechguy2/scioly-gallery-docker/releases/download/0.1/phpBB-3.2.9.zip -o phpBB-3.2.9.zip;

  unzip phpBB-3.2.9.zip;
  mv phpBB3/ public/;

  docker volume rm docker-lamp-stack_db_data;

  echo "Install complete. Starting Docker...";
  sleep 1;
  docker-compose up -d;

  echo ""
  echo "	Everything is working! Go to http://localhost:8080 to configure phpBB3. Remove public/install folder when you are done";
  echo "";
  echo "Go to http://localhost:9999 to see live logs."

fi

