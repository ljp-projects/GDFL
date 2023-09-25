# GDFL

**Generic Data Format Language**

It compiles to JSON.

**Make the file extension .gdfl**

## Features

* Only strings
* Values and arrays
* Shorter syntax

**GDFL**
```
{name} <Generic Data Format Lang>
{desc} <A small, generic data format language that compiles to JSON.>
{tags} <#data,json,simple,generic#>
```
**Generated JSON**
```
{
	"name": "Generic Data Format Lang",
	"desc": "A small, generic data format language that compiles to JSON.",
	"tags": [
		"data",
		"json",
		"simple",
		"generic"
	]
}
```

## Transpilation
After you have downloaded the GDFL kit, run `chmod +x .gdfl` in the terminal. Then run `.gdfl`.

To transpile a file use `gdfl path/to/file.gdfl`. It will create a JSON file with the same name. **This will not work if you haven't run the above commands.**
