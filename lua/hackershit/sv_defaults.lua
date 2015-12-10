Default = {}

//Default Server Structure
Default.server = {
	ip = "something went wrong, please report this to an admin",
	website = [[
		<head>
		<link rel="stylesheet" type="text/css" href="https://raw.githubusercontent.com/twbs/bootstrap/master/dist/css/bootstrap.css">
		</head>
		<body style="background-color:#F9F9F9">
		<center>
		<h2>Please Login</h2>
		<hr>
		<form name="loginform">
			<label>Username:</label><br>
			<input type="text" name="usr" placeholder="username">
			<br><br>
			<label>Password:</label><br>
			<input type="password" name="pass" placeholder="password"><br><br>
			<input class="btn btn-default" type="submit" value="Login" onclick='console.dologin(document.loginform.usr.value, document.loginform.pass.value)'>
		</form>
		</center>
		</body>
	]],
	files = 
	{
		{ false, "cheese pizza", { { true, "niggers", 1, 2 }, { false, "some folder", { { false, "ANOTHER FOLDER?!", { { false, "ayy lmao", { { true, "fuck u", 69, 1337 } } } } } } } } },
		{ false, "shit", { { true, "jews", 1, 2 }, { true, "my anus", 1, 2 } } },
		{ true, "a file", 1, 2 }
	},
	secret = {
		owner = "NPC",
		login = {"admin", "password"}
	}
}

Default.login = [[
	<body style="background-color:white">
	Hello
	<hr>
	<input type='submit' onclick='console.log( "RUNLUA:chat.AddText(\"hello\")" )' />
	</body>
]]

Default.offline = [[
	<body style="background-color:white">
	<center>
	<p style="color:red">offline</p>
	</center>
]]


