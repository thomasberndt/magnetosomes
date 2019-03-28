---
layout: default
title: Switching modes of magnetosome chains
---
# Switching modes of magnetosome chains

{% include naming.md %}

{% assign image_files = site.static_files | where: "SwitchingMode", true %}
{% for myimage in image_files %}
## {{ myimage.basename }}
![{{ myimage.path }}](..{{ myimage.path }})
  
{% endfor %}
    