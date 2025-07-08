# CKAN Extension Catalog Template

This is a reusable and extensible YAML-based catalog template for managing CKAN extensions.
It defines the structure needed to describe, install, configure, and manage CKAN extensions in a standardized way.

## Template Structure

```yaml
---
extensions:
  - name: "<extension-name>"
    url: "<git-url-or-source>"
    version: "<tag-or-branch>"
    description: >
      <Long multi-line description of the extension>

    supported_ckan_versions:
      - "<version>"
      - "<another-version>"

    plugins:
      - "<ckan.plugin.name1>"
      - "<ckan.plugin.name2>"

    configuration:
      has_config_declaration: <true|false>
      options:
        - key: "<ckan.config.key>"
          example: "<value>"
          default: "<value>"
          description: >
            <What this config option does>
          required: <true|false>

    setup:
      distributions:
        alpine:
          required_system_packages:
            - <apk-package-name>
            - <another-package>
        ubuntu:
          required_system_packages:
            - <apt-package-name>
      has_pyproject_toml: <true|false>
      has_requirements: <true|false>
      has_dev_requirements: <true|false>
      init-config:
        - "<post-install CLI commands>"
      afterinit-config:
        - "<run-after-init commands>"

    metadata:
      keywords:
        - "<keyword1>"
        - "<keyword2>"
```

---

## Example

```yaml
- name: "ckanext-pages"
  url: "https://github.com/ckan/ckanext-pages"
  version: "v0.5.2"
  description: >
    This extension gives you an easy way to add simple pages to CKAN.
    By default you can add pages to the main CKAN menu.
  supported_ckan_versions:
    - "2.10"
  plugins:
    - "pages"
  configuration:
    has_config_declaration: false
    options:
      - key: "ckanext.pages.organization"
        example: "False"
        default: "False"
        description: >
          Allow page creation in organization tab
        required: false
  setup:
    distributions:
      alpine:
        required_system_packages:
          - bash
    has_pyproject_toml: false
    has_requirements: true
    has_dev_requirements: true
    init-config:
      - "ckan -c production.ini pages initdb"
    afterinit-config: []
  metadata:
    keywords:
      - "pages"
      - "ckanext-pages"
```

---

## How to Use the Template

### 1. Add New Extensions

Copy and paste one of the extension blocks and modify the fields:

```yaml
- name: "ckanext-myextension"
  url: "https://github.com/myorg/ckanext-myextension"
  version: "main"
  ...
```

### 2. Use with Automation Tools

This catalog can be used with CKAN management tools (e.g., `ckan-pilot`) to:

* Install extensions
* Fetch system packages
* Set CKAN config keys
* Initialize extension databases

### 3. Validation Tips

* Ensure all required keys exist (`name`, `url`, `version`, `plugins`)
* `configuration.options` should have meaningful defaults and examples if included
* `setup.distributions` should be provided per base image (e.g., `alpine`, `ubuntu`)

### 4. Optional Keys

If a section isn’t needed (e.g., no config or init), you can:

* Set it to `null`, an empty list (`[]`), or omit it entirely

### 5. Configuration Notes

If your extension already declares its configuration options via code (e.g., using `config` in your CKAN plugin):

```yaml
configuration:
  has_config_declaration: true
```

You **do not need to define** the `options:` block manually.

However, if `has_config_declaration` is set to `false`, you **should define** the full list of configuration options explicitly:

```yaml
configuration:
  has_config_declaration: false
  options:
    - key: "ckanext.pages.allow_html"
      example: "False"
      default: "False"
      description: >
        Enables HTML output for the pages (along with Markdown)
      required: false
```

This helps tools generate documentation, default `.ini` files, and provide user-friendly config UIs.

---
