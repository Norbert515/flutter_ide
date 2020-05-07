
# Wrappers for widgets

Some widgets have ambigous property access. For example the container.

After creating a container you cannot know whether the constraints are 
because of the user passing constrains or setting the width/height.

That's why there are wrapper widgets which make this distinction.