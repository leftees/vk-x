Opera 12 does not allow to access resources from web,
so script file injection is only possible with background
script which does have access to local resources.
Originally **VkOpt** used background script which loaded source files
and passed them to this script as strings. They were then
`eval`ed here.
Now we use **gulp** to concat source code and inject it below.

These two event handlers and `index.html` provide
old interface for cross-origin ajax until new one won't be implemented.
See: `vk_ext_api` object defined in `vk_lib.js`.

	opera.extension.addEventListener "message", ({ data }) ->
		window.postMessage data, "*"
	, false

	window.addEventListener "message", ({ data }) ->
		# Pass request to background.js
		opera.extension.postMessage data if data.mark is "vkopt_loader"
	, false

Although this file runs in the page context, there're some
weird errors when trying to run source code without `eval()`.
Needs further investigation because `eval()` is too slow to leave it so.

	# See: content_script.js:23
	window._ext_ldr_vkopt_loader = true

	# See: gulpfile.litcoffee
	gulpShouldFillThis = "This will be replaced with the source"
	window.eval gulpShouldFillThis
