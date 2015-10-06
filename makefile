deploy:
	rm -rf ../sherwinkoo.github.com/*
	cp -r ./_site/ ../sherwinkoo.github.com/
	cp ./CNAME ../sherwinkoo.github.com/ 
	cd ../sherwinkoo.github.com/; git add --all; git commit -m "ADD: new post"; git push
