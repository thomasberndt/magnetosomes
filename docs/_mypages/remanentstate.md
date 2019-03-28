---
layout: default
title: Remanent states of magnetosome chains
---
# Remanent states of magnetosome chains

{% include naming.md %}

{% assign image_files = site.static_files | where: "RemanentState", true %}
{% for myimage in image_files %}
## {{ myimage.basename }}
![{{ myimage.path }}](..{{ myimage.path }})
  
{% endfor %}
    