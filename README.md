# MemoryleaksTestApp

This TestApp is created to demonstrate why we should be using `unowned` and `weak` keywords in swift when working with closures. 

You can try it out yourself by running the app first as is and then with `[unowned self]` commented out in the ViewController class. When looking at the memory usage data in XCode you will see how some of the memory is not freed in the second run through. 

