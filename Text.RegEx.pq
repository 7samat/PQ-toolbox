let
    fun = (input as text,pattern as text) as list =>
    let
        x = Character.FromNumber(34) & Text.Replace(input,Character.FromNumber(34),"\"&Character.FromNumber(34)) & Character.FromNumber(34),
        y =  Text.Replace(pattern,"\","\\"),
        fx=(x,y)=>
            Web.Page(
            "<script>
                var x="&x&";
                var y=new RegExp('"&y&"','g');
                var b=x.match(y);
                document.write(b);
            </script>")[Data]{0}[Children]{0}[Children]{1}[Text]{0},
        tempResult = fx(x,y),
        result = if tempResult="null" then {null} else Text.Split(tempResult,",")
    in 
    result,

    
    myMeta =         [
            Documentation.Name = "Text.RegEx",
            Documentation.Author = "Jakub Tamas",
            Documentation.LongDescription = "Returns a list of matches in a string by criteria provided in a RegEx expression. Note: It is a basic javascript implementation of RegEx.",
            Documentation.Examples = 
            {
                [
                    Description = "Extract all valid dates from the list, allowing for 4 different seperators and only yyyy mm dd format",
                    Code = "Text.RegEx((""2017/01/01;2018-12-31;18-01-01;2099.07.31;2099.07.32;1905/13/01;2018 07 07;2019-07/07;2000:01:01"", ""(19|20)\d\d[- /.](0[1-9]|1[012])[- /.](0[1-9]|[12][0-9]|3[01])"")",
                    Result = "{""2017/01/01"",""2018-12-31"",""2099.07.31"",""2018 07 07"",""2019-07/07""}"
                ],
                [
                    Description = "Extract resolution information from product specification",
                    Code = "Text.RegEx(""15.4-inches widescreen TFT LCD display, 1280x800 resolution"",""\d{3,4}\s?x\s?\d{3,4}"")",
                    Result = "{""1280x800""}"
                ],
                [
                    Description = "Extract all valid email adresses from a conversation",
                    Code = "Text.RegEx(""@User1: my email is user1@test.com; @User2: My email is user2@test,com' @User2: Sorry! Make that user2@test.com"", ""([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+)"")",
                    Result = "{""user1@test.com"",""user2@test.com""}"
                ]
            }
        ],


    myType = type function
    (
        input as text,pattern as text
    ) as list meta myMeta

in
Value.ReplaceType(fun,myType)
