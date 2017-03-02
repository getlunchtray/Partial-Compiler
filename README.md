[![Build Status](https://travis-ci.org/getlunchtray/partial-compiler.svg?branch=master)](https://travis-ci.org/getlunchtray/partial-compiler) [![Gem Version](https://badge.fury.io/rb/partial_compiler.svg)](https://badge.fury.io/rb/partial_compiler)

# Partial Compiler
*This is very beta right now, not suggested for production projects at the moment*

Partial Compiler allows you to execute your code in a single template file in production environments.

## Setup

**Initializer**

Create an initializer file:

`config/initializers/partial_compiler.rb`

```
# Optional config
PartialCompiler.configure({
 
})

PartialCompiler.start
```

Default Configuration:

```
 {
    template_engine: ActionView::Template::Handlers::ERB,
    original_extension: "html.erb",
    rendering_engine_partial_format: "= render partial:",
    regex_partial_eval_match: /(render .*)%>/,
    run_compiled: !Rails.env.development?
 }
```

`run_compiled` is likely going to be the only thing you'll want to change. This just tells PC when to use the `.compiled` file and when to use the `.uc` file.

**File Names**

To get PC to recognize your files, you'll need to change the extensions. 

`index.html.erb` will need to become `index.uc.html.erb` *Notice the 'uc' before 'html'* Don't create a copy, simply change the file extension.

This only needs to be done for files you want to compile. **Do not change the extension of your partials**

## How does it work?

Given a file like:

`index.uc.html.erb` 

Partial Compiler will find all of the partials in said file, extract the code, and create a new file:

`index.compiled.html.erb`

What's neat is PC will only register template handlers for uc.html.erb in development and compiled.html.erb in production. Meaning you can continue to use  your partials in development.

## Example

If you have a template and a partial like:

`index.uc.html.erb`

```
<div class="container">
  My code in a container
</div>
<span>
  <%= render partial: "my_awesome_partial" %>
</span>
```
`_my_awesome_partial.html.erb`

```
<h1>Look! I'm in a partial!</h1>
<ul>
  <li>Red Potato</li>
  <li>Hot Potato</li>
  <li>French Potato</li>
</ul>
```

Partial Compiler will turn this into:

`index.compiled.html.erb`

```
<div class="container">
  My code in a container
</div>
<span>
  <h1>Look! I'm in a partial!</h1>
  <ul>
    <li>Red Potato</li>
    <li>Hot Potato</li>
    <li>French Potato</li>
  </ul>
</span>
```

## Gotchas

#### Locals

For locals, the keys cannot share a name with variables in the template. Let me explain:

Assume you have a template that looks like this:

```
<% my_awesome_variable = "Welcome" %>
<div class="container">
  <h1>
    <%= render partial: "my_partial", locals: {my_awesome_variable: "Goodbye"} %>
  </h1>
  <p><%= my_awesome_variable %></p>
</div>
```

The uncompiled version will work exactly as you'd expect. The H1 will print out "Goodbye" and the paragraph will print out "Welcome."

At the moment, when locals are inserted into the compiled template, they're added just above where the partial was rendered:

```
<% my_awesome_variable = "Welcome" %>
<div class="container">
  <h1>
    <% my_awesome_variable = "Goodbye" %>
    <div>
      <%= my_awesome_variable %>
    </div>
  </h1>
  <p><%= my_awesome_variable %></p>
</div>
```

So now both your H1 and paragraph will both say "Goodbye"! 

![](readme-files/totally-justified-full-house-meme.jpg)

Long story short, just make sure your variables and locals are different names. Also, please excuse my wacky HTML, I don't actually write like that ;)

#### Line Spacing

Partials must be rendered on their own line.

Instead of this:

```
<h1><%= render partial: "my_partial" %></h1>
```

Do this:

```
<h1>
  <%= render partial: "my_partial" %>
</h1>
```

Indentation, however, will be honoured.

## To Do

1. Refactor compiler.rb file
2. Allow locals and template variables to share the same name
3. Haml support
4. Slim Support
 

