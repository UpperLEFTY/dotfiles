tell application "System Events"
	if not autohide dictionary in applications then
		set autohide dictionary app  in applications to true
	else
		set autohide dictionary app in applications to false
	end if
end tell


needs more work, not currently working