# Partial Compiler
*Still a work in progress, cooler name to be created later*

Partial Compiler allows you to execute your code in a single template file in production environments.

## How?

Given a file like:

`index.uc.html.erb` *Notice the 'uc' before 'html'*

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

## Work in Progress
More things coming...

1. Locals support
2. Haml support
3. Slim Support
 

