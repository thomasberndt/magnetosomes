---
layout: default
title: Remanent states of strongly elongated bar-like particles of the same dimensions as a complete magnetosome chain
---
# Remanent states of strongly elongated bar-like particles of the same dimensions as a complete magnetosome chain

{% include naming.md %}

{% assign image_files = site.static_files | where: "Bars_remanent", true %}
{% for myimage in image_files %}
## {{ myimage.basename }}
![{{ myimage.path }}](..{{ myimage.path }})
  
{% endfor %}
    