var request = require('request')
	, path = require('path')
	, fs = require('fs')
	, url = "https://api.github.com/users/thomastraum/gists"
	, savepath = './gists';

request(url, function (error, response, body) {
	
	if (!error && response.statusCode == 200) {

		gists = JSON.parse( body );
		gists.forEach( function(gist) {
			
			console.log( "description: ", gist.description );
			var dir = savepath + '/' + gist.description;

			fs.mkdir( dir, function(err){
				for(var file in gist.files){

					var raw_url = gist.files[file].raw_url;
					var filename = gist.files[file].filename;

					console.log( "downloading... " + filename );
					request(raw_url).pipe(fs.createWriteStream( dir + '/' + filename ));
				}
			});
		});

  	}

});
