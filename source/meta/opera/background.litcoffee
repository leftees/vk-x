This script runs in background and has a permission
to do cross-origin ajax requests.
See: `source/meta/opera/index.html`.

	app = require "../../app"
	performRequest = require( "../../ajax/perform-request" ) app

	handleBackgroundAjax = ({ data, source }) ->
		callback = ( responseData ) ->
			source.postMessage responseData
		performRequest { data, source, callback }

	opera.extension.onmessage = handleBackgroundAjax
