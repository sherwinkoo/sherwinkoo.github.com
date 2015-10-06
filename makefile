deploy:
	rm -rf ../sherwinkoo.github.com/*
	cp -r ./_site/ ../sherwinkoo.github.com/
	cp ./CNAME ../sherwinkoo.github.com/ 
	cd ../sherwinkoo.github.com/; git commit -am "ADD: new post"; git push
