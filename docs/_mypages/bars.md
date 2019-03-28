---
layout: default
title:  Animated hysteresis loops of strongly elongated bar-like particles of the same dimensions as a complete magnetosome chain
---
# Strongly elongated bar-like particles of the same dimensions as a complete magnetosome chain

{% include naming.md %}

{% assign image_files = site.static_files | where: "Bars", true %}
{% for myimage in image_files %}
## {{ myimage.basename }}
![{{ myimage.path }}](..{{ myimage.path }})
  
{% endfor %}
    