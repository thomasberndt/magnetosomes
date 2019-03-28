---
layout: default
title: Animated hysteresis loops of 10-element equant (cubic) magnetosome chains (field near perpendicular to chain axis)
---
# Hysteresis loops of 10-element equant (cubic) magnetosome chains

{% include naming.md %}

{% assign image_files = site.static_files | where: "Equant_perp", true %}
{% for myimage in image_files %}
## {{ myimage.basename }}
![{{ myimage.path }}](..{{ myimage.path }})
  
{% endfor %}
    