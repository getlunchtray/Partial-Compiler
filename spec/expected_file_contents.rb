EXPECTED_FILE_CONTENTS = {
  multiple: "<div>\n  Hello from file one\n</div>\n\n<div>\n  Hello from file two\n</div>",
  contains_bad_file_path: "<%= render partial: \"i_dont_exist\" %>",
  different_file: "I'm in a different directory",
  indentation: "<h1> Welcome to my indented page! </h1> \n\n<div class=\"container\">\n  Don't indent me, bro\n    Keep me indented\n  <div>\n    Help! I'm stuck in this pointless div!\n  </div>\n</div>",
  basic: "I'm so basic it hurts",
  with_locals: "<div>\n  <% header1= \"First Header\";header2= \"Second Header\" %>\n  I'm a partial that contains locals\n  \n  <h1><%= header1 %></h1>\n  <h2><%= header2 %></h2>\n</div>" 
}

def expected_file_contents_for file_name
  EXPECTED_FILE_CONTENTS[file_name.to_sym] || ""
end
