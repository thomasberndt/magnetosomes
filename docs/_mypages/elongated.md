---
layout: default
title: Animated hysteresis loops of 10-element elongated (e=1.4) magnetosome chains
---
# Hysteresis loops of 10-element elongated (e=1.4) magnetosome chains

{% include naming.md %}

{% assign image_files = site.static_files | where: "Elongated", true %}
{% for myimage in image_files %}
## {{ myimage.basename }}
![{{ myimage.path }}](..{{ myimage.path }})
  
{% endfor %}
    