# Powershell

## Operators

[about_Operators](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_operators?view=powershell-7.2)


* [**Arithmetic Operators**](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arithmetic_operators?view=powershell-7.2)
  * calculate values in a command or expression
    * `+` , `-` , `*` , `/` , `%`

* **Bitwise operators**
  * manipulate the bit patterns in values
    * `-band` , `-bor` , `-bxor` , `-bnot` , `-shl` , `-shr`

* [**Assignment Operators**](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_assignment_operators?view=powershell-7.2)
  * assign, change, or append values to variables
    * `=` , `+=` , `-=` , `*=` , `/=` , `%=`

* [**Comparison Operators**](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-7.2)
  * compare values and test conditions
    * `-eq` , `-ne` , `-gt` , `-lt` , `-le` , `-ge`
  * string match
    * regex
      * `-match` , `-notmatch` , `-replace`
    * wildcard (`*`)
      * `-like` , `-notlike`
  * Containment - value appears in a reference set
    * `-in` , `-notin` , `-contains` , `-notcontains`
  * Type - object is of a given type
    * `-is` , `-isnot`


* [**Logical Operators**](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_logical_operators?view=powershell-7.2)
  * connect conditional statements into a single complex conditional
    * `-and` , `-or` , `-xor` , `-not` , `!`


* [**Redirection Operators**](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_redirection?view=powershell-7.2)
  * send the output of a command or expression to a text file
    * `>` , `>>` , `2>` , `2>>` , and `2>&1`

* **[Split](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_split?view=powershell-7.2) and [Join](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_join?view=powershell-7.2) Operators**
  * divide and combine substrings
    * `-split` , `-join`


* [**Type Operators**](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_type_operators?view=powershell-7.2)
  * find or change the .NET Framework type of an object
    * `-is` , `-isnot` , `-as`

* **Unary Operators**
  * increment or decrement values
    * `++` , `--`

* **Grouping operator** `( )`
  * let output from a command participate in an expression
    * ex. `(Get-Item *.txt).Count -gt 10`

* **Subexpression operator** `$( )`
  * Returns the result of one or more statements. For a single result, returns a scalar. For multiple results, returns an array
    * ex. `"Today is $(Get-Date)"`

* **Array subexpression operator** `@( )`
  * Returns the result of one or more statements as an array
    * ex. `$list = @(Get-Process | Select-Object -First 10; Get-Service | Select-Object -First 10 )`


* [**Hash table literal syntax**](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_hash_tables?view=powershell-7.2) `@{}`
  * declare a hash table
    * ex. `${ Name = "Kyle" }`

* **Call operator** `&`
  * Runs a command, script, or script block

    ```ps1
    PS> $cmd = "get-executionpolicy"
    PS> & $cmd
    ```

* **Background operator** `&`
  * Runs the pipeline before it in the [background](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_jobs?view=powershell-7.2)
    * ex. `Get-Process -Name pwsh &`
      * ≈ `Start-Job -ScriptBlock {Get-Process -Name pwsh}`

* **Cast operator** `[ ]`
  * Converts or limits objects to the specified type
    * ex. `[DateTime] '2/20/88'`

* **Cast Notation**
  * ensure that a variable can contain only specific object types
    * ex. `[int]$number = 8`


* **Comma operator** `,`
  * creates an array or appends to the array being created
    * ex. `$myArray = 1,2,3`

* **Dot sourcing operator** `.`
  * Runs a script in the current scope
    * ex. `. c:\scripts\sample.ps1 1 2 -Also:3`

* [**Format operator**](https://docs.microsoft.com/en-us/dotnet/standard/base-types/composite-formatting) `-f`
  * Formats strings by using the format method of string objects
    * ex. `"{0} {1,-10} {2:N}" -f 1,"hello",[math]::pi`

* **Index operator** `[ ]`
  * Selects objects from indexed collections
    * ex: `$a = 1, 2, 3; $a[0]`

* **Pipeline operator** `|`
  * Sends ("pipes") the output of the command that precedes it to the command that follows it
    * ex. `Get-Process | Get-Member`

* **Pipeline chain operators** `&&` and `||`
  * Conditionally execute the right-hand side pipeline based on the success of the left-hand side pipeline.
    * ex. `Get-Process notepad && Stop-Process -Name notepad`


* **Range operator** `..`
  * Represents the sequential integers in an integer array
    * ex. `1..10 | ForEach-Object {Write-Output $_}`

* **Member access operator** `.`
  * Accesses the properties and methods of an object.
    * ex. `(Get-Process PowerShell).kill()`

* **Static member operator** `::`
  * Calls the static properties and methods of a .NET Framework class
    * ex. `[datetime]::Now`

* [**Ternary operator**](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_if?view=powershell-7.2#using-the-ternary-operator-syntax) `? <if-true> : <if-false>`
  * simplified if-else statement
    * ex. `$message = (Test-Path $path) ? "Path exists" : "Path not found"`

* **Null-coalescing operator** `??`
  * returns the value of its left-hand operand if it isn't null. Otherwise, it evaluates the right-hand operand and returns its result
    * ex. `$x = $null; $x ?? 100`

* **Null-coalescing assignment operator** `??=`
  * assigns the value of its right-hand operand to its left-hand operand only if the left-hand operand evaluates to null
    * ex. ``$todaysDate ??= (Get-Date).ToShortDateString()`

* **Null-conditional operators** `?.` and `?[]`
  * applies a member access (`?.`) or element access (`?[]) operation to its operand only if that operand evaluates to non-null; otherwise, it returns null
    * ex: `$a = @{ PropName = 100 }; ${a}?.PropName`


