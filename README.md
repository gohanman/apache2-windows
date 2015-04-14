Chef Cookbook for Apache 2 on Windows
=====================================

Installs and configures Apache 2 on Windows.

Requirements
------------
#### packages

- windows
- vcruntime

Supported Platforms
-------------------
Microsoft Windows 2008 R2 and up.

Usage
-----
#### apache2_windows::default

Just include `apache2_windows` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[apache2_windows]"
  ]
}
```

License and Authors
-------------------

* Author:: Yvo Van Doorn (yvo@getchef.com)
* Author:: Chris McClimans (hh@hippiehacker.org)
* Author:: Dan Robinson (dan@getchef.com)
* Author:: Julian Dunn (jdunn@getchef.com)
* Author:: James Francis (james@gnslngr.us)
* Author:: Andy Theuninck (andy@gohanman.com>

* Copyright (C) 2013-2014 Chef Software, Inc.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
