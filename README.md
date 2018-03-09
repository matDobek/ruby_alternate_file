# Description
Simple script for creating alternative test files.

# Usage

```
./main ~/repositories/rails_app/app/sample.rb minitest
```

Will create:

```
# ~/repositories/rails_app/test/sample_test.rb
require "test_helper"

class Test < ActiveSupport::TestCase
end
```

# Editors
## vim

Bind creating alternate file under a key

```
autocmd FileType ruby noremap <Leader>rA :! PATH_TO_THE_REPO/main %:p minitest <CR>
```
