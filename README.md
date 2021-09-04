# neat

A collection of opinionated convenient widgets.

## How to use

```
class MyAppDimensions extends NeatTheme {
    @spaces
    static const space1;
    static const space2;
    static const space3;
    static const space4;
    static const space5;
    static const space6;
}


Column(
    children: [        
        Space1(), // SizedBox(width: MyAppDimensions.space1, height: MyAppDimensions.space1),
        Space1.w(), // SizedBox(width: MyAppDimensions.space1),
        Space1.h(), // SizedBox(height: MyAppDimensions.space1),
        Padding.space1(
            child: MyWidget(),
        )
        Theme.of(context).space.space1,
    ]
)

```

