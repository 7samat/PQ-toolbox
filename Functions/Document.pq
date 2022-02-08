let
    func = 
        (name as text, description as text, valueOrExample as any, optional valueIfExample as any) =>
        let
            value = if valueIfExample is null then valueOrExample else valueIfExample,
            examples = if valueIfExample is null then {} else valueOrExample
        in
            Value.ReplaceType(value, Value.Type(value) meta [
                Documentation.Name = name, 
                Documentation.Description = description,  
                //Example schema is [Description = "", Code="", Result =""]
                Documentation.Examples = examples
            ])
in
    func(
        "Document",
        "Creates a convenient method of adding documentation to other functions",
        func
    )
