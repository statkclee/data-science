---
layout: page
title: 데이터 과학
subtitle: ggvis
output:
  html_document: 
    keep_md: yes
  pdf_document:
    latex_engine: xelatex
mainfont: NanumGothic
---



### 1. `ggvis` 개요 

[ggvis](http://ggvis.rstudio.com/)는 R의 강력한 데이터 분석엔진을 HTML5와 자바스크립트를 결합하여 인터랙티브 상호작용과 화면출력을 접목하고자 [Winston Chang](https://github.com/wch)이 주도되어 개발되었다. 물론 그래픽 문법(Grammer of Graphics)과 ggplot2에 기반하고 있다.

> ### `ggvis`가 바라본 그래프 {.callout}
>
> 그래프 = 데이터 + 좌표 시스템 + 표식 + 속성 + ...     
>
> Graph = `iris` + `cartesian` + `points` + `fill=`

[데이터 캠프(datacamp)](https://www.datacamp.com/courses/ggvis-data-visualization-r-tutorial) **Data Visualization in R with ggvis** 과정에 그래픽 문법 개념을 잘 설명하고 있다.

<img src="fig/ds-ggvis-grammer-of-graphics.png" alt="그래픽 문법 개념 설명" width="100%" />

### 2. `ggvis` 예제

#### 2.1. `ggvis` 산점도와 평활선

`library(ggvis)` 명령어로 `ggvis` 라이브러리를 불러온다. 파이프 연산자를 사용해서 `mtcars` 데이터셋을 `ggvis` 함수에 넣어 차량무계(`wt`)와 연비(`mpg`)를 데카르트 좌표계에 넣고,
`layer_points()` 함수로 점을 찍고, `layer_smooths()` 함수로 평활선을 추가한다.


~~~{.r}
library(ggvis)
mtcars %>% ggvis(~wt, ~mpg) %>% 
           layer_points() %>% 
           layer_smooths()
~~~

<!--html_preserve--><div id="plot_id460137769-container" class="ggvis-output-container">
<div id="plot_id460137769" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id460137769_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id460137769" data-renderer="svg">SVG</a>
 | 
<a id="plot_id460137769_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id460137769" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id460137769_download" class="ggvis-download" data-plot-id="plot_id460137769">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id460137769_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "wt": "number",
          "mpg": "number"
        }
      },
      "values": "\"wt\",\"mpg\"\n2.62,21\n2.875,21\n2.32,22.8\n3.215,21.4\n3.44,18.7\n3.46,18.1\n3.57,14.3\n3.19,24.4\n3.15,22.8\n3.44,19.2\n3.44,17.8\n4.07,16.4\n3.73,17.3\n3.78,15.2\n5.25,10.4\n5.424,10.4\n5.345,14.7\n2.2,32.4\n1.615,30.4\n1.835,33.9\n2.465,21.5\n3.52,15.5\n3.435,15.2\n3.84,13.3\n3.845,19.2\n1.935,27.3\n2.14,26\n1.513,30.4\n3.17,15.8\n2.77,19.7\n3.57,15\n2.78,21.4"
    },
    {
      "name": ".0/model_prediction1",
      "format": {
        "type": "csv",
        "parse": {
          "pred_": "number",
          "resp_": "number"
        }
      },
      "values": "\"pred_\",\"resp_\"\n1.513,32.08897233857\n1.56250632911392,31.6878645869701\n1.61201265822785,31.2816303797919\n1.66151898734177,30.8703709543688\n1.7110253164557,30.4541875480347\n1.76053164556962,30.0331813981232\n1.81003797468354,29.6074537419678\n1.85954430379747,29.1771058169022\n1.90905063291139,28.7422388602601\n1.95855696202532,28.3001719301537\n2.00806329113924,27.834621969428\n2.05756962025316,27.3476575600419\n2.10707594936709,26.84497968394\n2.15658227848101,26.3322893230667\n2.20608860759494,25.8152874593666\n2.25559493670886,25.2996750747841\n2.30510126582278,24.7911531512637\n2.35460759493671,24.29542267075\n2.40411392405063,23.8181846151875\n2.45362025316456,23.3651399665205\n2.50312658227848,22.955253039598\n2.55263291139241,22.6138488714952\n2.60213924050633,22.3275852300224\n2.65164556962025,22.0817586181852\n2.70115189873418,21.8616655389892\n2.7506582278481,21.65260249544\n2.80016455696203,21.4398659905432\n2.84967088607595,21.2087525273044\n2.89917721518987,20.953335722037\n2.9486835443038,20.7158424594628\n2.99818987341772,20.4957065225374\n3.04769620253165,20.2829337645837\n3.09720253164557,20.0675300389245\n3.14670886075949,19.8395011988825\n3.19621518987342,19.5888530977805\n3.24572151898734,19.2971559094315\n3.29522784810127,18.9444093670088\n3.34473417721519,18.5670026794964\n3.39424050632911,18.2056968860288\n3.44374683544304,17.9009022641924\n3.49325316455696,17.620602502374\n3.54275949367089,17.3400153015964\n3.59226582278481,17.079077805285\n3.64177215189873,16.8175887231322\n3.69127848101266,16.5575726926136\n3.74078481012658,16.3083303048321\n3.79029113924051,16.0791621508901\n3.83979746835443,15.8793688218903\n3.88930379746835,15.7018119854881\n3.93881012658228,15.5259429561214\n3.9883164556962,15.3517253848296\n4.03782278481013,15.1793328075288\n4.08732911392405,15.0089387601353\n4.13683544303798,14.8407167785652\n4.1863417721519,14.6748403987346\n4.23584810126582,14.5114831565596\n4.28535443037975,14.3508185879563\n4.33486075949367,14.193020228841\n4.3843670886076,14.0382616151298\n4.43387341772152,13.8867162827388\n4.48337974683544,13.7385577675841\n4.53288607594937,13.5939596055819\n4.58239240506329,13.4530953326483\n4.63189873417722,13.3161384846995\n4.68140506329114,13.1832625976516\n4.73091139240506,13.0546412074207\n4.78041772151899,12.930447849923\n4.82992405063291,12.8108560610747\n4.87943037974684,12.6960393767918\n4.92893670886076,12.5861713329905\n4.97844303797468,12.4814254655869\n5.02794936708861,12.3819753104973\n5.07745569620253,12.2879944036376\n5.12696202531646,12.1996562809241\n5.17646835443038,12.117134478273\n5.2259746835443,12.0406025316002\n5.27548101265823,11.9702339768221\n5.32498734177215,11.9062023498547\n5.37449367088608,11.8486811866141\n5.424,11.7978440230166"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.31745\n5.61955"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "fill": {
            "value": "#000000"
          },
          "size": {
            "value": 50
          },
          "x": {
            "scale": "x",
            "field": "data.wt"
          },
          "y": {
            "scale": "y",
            "field": "data.mpg"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    },
    {
      "type": "line",
      "properties": {
        "update": {
          "stroke": {
            "value": "#000000"
          },
          "strokeWidth": {
            "value": 2
          },
          "x": {
            "scale": "x",
            "field": "data.pred_"
          },
          "y": {
            "scale": "y",
            "field": "data.resp_"
          },
          "fill": {
            "value": "transparent"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0/model_prediction1"
          }
        }
      },
      "from": {
        "data": ".0/model_prediction1"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "wt"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 504,
    "height": 504
  },
  "handlers": null
};
ggvis.getPlot("plot_id460137769").parseSpec(plot_id460137769_spec);
</script><!--/html_preserve-->

#### 2.2. `ggvis` 선그림

`ggvis` 라이브러리로 선그림도 가능하다. 동일한 `mtcars` 데이터셋과 동일한 데카르트 좌표계를 사용해서 `ggvis` 함수에 넣어 차량무계(`wt`)와 연비(`mpg`)를 넣고,
`layer_lines()` 함수에 색상, 선폭, 선모양을 차별화해서 시각화한다.


~~~{.r}
mtcars %>% ggvis(~wt, ~mpg) %>% 
           layer_lines(stroke:="red", strokeWidth:=2, strokeDash:=6) %>% 
           layer_smooths()
~~~

<!--html_preserve--><div id="plot_id813305678-container" class="ggvis-output-container">
<div id="plot_id813305678" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id813305678_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id813305678" data-renderer="svg">SVG</a>
 | 
<a id="plot_id813305678_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id813305678" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id813305678_download" class="ggvis-download" data-plot-id="plot_id813305678">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id813305678_spec = {
  "data": [
    {
      "name": ".0/arrange1",
      "format": {
        "type": "csv",
        "parse": {
          "wt": "number",
          "mpg": "number"
        }
      },
      "values": "\"wt\",\"mpg\"\n1.513,30.4\n1.615,30.4\n1.835,33.9\n1.935,27.3\n2.14,26\n2.2,32.4\n2.32,22.8\n2.465,21.5\n2.62,21\n2.77,19.7\n2.78,21.4\n2.875,21\n3.15,22.8\n3.17,15.8\n3.19,24.4\n3.215,21.4\n3.435,15.2\n3.44,18.7\n3.44,19.2\n3.44,17.8\n3.46,18.1\n3.52,15.5\n3.57,14.3\n3.57,15\n3.73,17.3\n3.78,15.2\n3.84,13.3\n3.845,19.2\n4.07,16.4\n5.25,10.4\n5.345,14.7\n5.424,10.4"
    },
    {
      "name": ".0/model_prediction2",
      "format": {
        "type": "csv",
        "parse": {
          "pred_": "number",
          "resp_": "number"
        }
      },
      "values": "\"pred_\",\"resp_\"\n1.513,32.08897233857\n1.56250632911392,31.6878645869701\n1.61201265822785,31.2816303797919\n1.66151898734177,30.8703709543688\n1.7110253164557,30.4541875480347\n1.76053164556962,30.0331813981232\n1.81003797468354,29.6074537419678\n1.85954430379747,29.1771058169022\n1.90905063291139,28.7422388602601\n1.95855696202532,28.3001719301537\n2.00806329113924,27.834621969428\n2.05756962025316,27.3476575600419\n2.10707594936709,26.84497968394\n2.15658227848101,26.3322893230667\n2.20608860759494,25.8152874593666\n2.25559493670886,25.2996750747841\n2.30510126582278,24.7911531512637\n2.35460759493671,24.29542267075\n2.40411392405063,23.8181846151875\n2.45362025316456,23.3651399665205\n2.50312658227848,22.955253039598\n2.55263291139241,22.6138488714952\n2.60213924050633,22.3275852300224\n2.65164556962025,22.0817586181852\n2.70115189873418,21.8616655389892\n2.7506582278481,21.65260249544\n2.80016455696203,21.4398659905432\n2.84967088607595,21.2087525273044\n2.89917721518987,20.953335722037\n2.9486835443038,20.7158424594628\n2.99818987341772,20.4957065225374\n3.04769620253165,20.2829337645837\n3.09720253164557,20.0675300389245\n3.14670886075949,19.8395011988825\n3.19621518987342,19.5888530977805\n3.24572151898734,19.2971559094315\n3.29522784810127,18.9444093670088\n3.34473417721519,18.5670026794964\n3.39424050632911,18.2056968860288\n3.44374683544304,17.9009022641924\n3.49325316455696,17.620602502374\n3.54275949367089,17.3400153015964\n3.59226582278481,17.079077805285\n3.64177215189873,16.8175887231322\n3.69127848101266,16.5575726926136\n3.74078481012658,16.3083303048321\n3.79029113924051,16.0791621508901\n3.83979746835443,15.8793688218903\n3.88930379746835,15.7018119854881\n3.93881012658228,15.5259429561214\n3.9883164556962,15.3517253848296\n4.03782278481013,15.1793328075288\n4.08732911392405,15.0089387601353\n4.13683544303798,14.8407167785652\n4.1863417721519,14.6748403987346\n4.23584810126582,14.5114831565596\n4.28535443037975,14.3508185879563\n4.33486075949367,14.193020228841\n4.3843670886076,14.0382616151298\n4.43387341772152,13.8867162827388\n4.48337974683544,13.7385577675841\n4.53288607594937,13.5939596055819\n4.58239240506329,13.4530953326483\n4.63189873417722,13.3161384846995\n4.68140506329114,13.1832625976516\n4.73091139240506,13.0546412074207\n4.78041772151899,12.930447849923\n4.82992405063291,12.8108560610747\n4.87943037974684,12.6960393767918\n4.92893670886076,12.5861713329905\n4.97844303797468,12.4814254655869\n5.02794936708861,12.3819753104973\n5.07745569620253,12.2879944036376\n5.12696202531646,12.1996562809241\n5.17646835443038,12.117134478273\n5.2259746835443,12.0406025316002\n5.27548101265823,11.9702339768221\n5.32498734177215,11.9062023498547\n5.37449367088608,11.8486811866141\n5.424,11.7978440230166"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.31745\n5.61955"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "line",
      "properties": {
        "update": {
          "x": {
            "scale": "x",
            "field": "data.wt"
          },
          "y": {
            "scale": "y",
            "field": "data.mpg"
          },
          "stroke": {
            "value": "red"
          },
          "strokeWidth": {
            "value": 2
          },
          "strokeDash": {
            "value": 6
          }
        },
        "ggvis": {
          "data": {
            "value": ".0/arrange1"
          }
        }
      },
      "from": {
        "data": ".0/arrange1"
      }
    },
    {
      "type": "line",
      "properties": {
        "update": {
          "stroke": {
            "value": "#000000"
          },
          "strokeWidth": {
            "value": 2
          },
          "x": {
            "scale": "x",
            "field": "data.pred_"
          },
          "y": {
            "scale": "y",
            "field": "data.resp_"
          },
          "fill": {
            "value": "transparent"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0/model_prediction2"
          }
        }
      },
      "from": {
        "data": ".0/model_prediction2"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "wt"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 504,
    "height": 504
  },
  "handlers": null
};
ggvis.getPlot("plot_id813305678").parseSpec(plot_id813305678_spec);
</script><!--/html_preserve-->

#### 2.3. `ggvis` 히스토그램, 밀도 그래프, 막대 그래프

`ggvis` 라이브러리로 물론 히스토그램과 밀도(denstiy) 그래프도 가능하다. 동일한 `mtcars` 데이터셋과 동일한 데카르트 좌표계를 사용해서 `ggvis` 함수에 넣어 연비(`mpg`)만 넣고, 
`layer_histograms()` 함수에 `width=7`을 인자로 넣어 히스토그램을 완성한다. 


~~~{.r}
mtcars %>% ggvis(~mpg) %>% 
           layer_histograms(width=7)
~~~

<!--html_preserve--><div id="plot_id825545188-container" class="ggvis-output-container">
<div id="plot_id825545188" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id825545188_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id825545188" data-renderer="svg">SVG</a>
 | 
<a id="plot_id825545188_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id825545188" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id825545188_download" class="ggvis-download" data-plot-id="plot_id825545188">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id825545188_spec = {
  "data": [
    {
      "name": ".0/bin1/stack2",
      "format": {
        "type": "csv",
        "parse": {
          "xmin_": "number",
          "xmax_": "number",
          "stack_upr_": "number",
          "stack_lwr_": "number"
        }
      },
      "values": "\"xmin_\",\"xmax_\",\"stack_upr_\",\"stack_lwr_\"\n3.5,10.5,2,0\n10.5,17.5,10,0\n17.5,24.5,14,0\n24.5,31.5,4,0\n31.5,38.5,2,0"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.75\n40.25"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n0\n14.7"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "rect",
      "properties": {
        "update": {
          "stroke": {
            "value": "#000000"
          },
          "fill": {
            "value": "#333333"
          },
          "x": {
            "scale": "x",
            "field": "data.xmin_"
          },
          "x2": {
            "scale": "x",
            "field": "data.xmax_"
          },
          "y": {
            "scale": "y",
            "field": "data.stack_upr_"
          },
          "y2": {
            "scale": "y",
            "field": "data.stack_lwr_"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0/bin1/stack2"
          }
        }
      },
      "from": {
        "data": ".0/bin1/stack2"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "count"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 504,
    "height": 504
  },
  "handlers": null
};
ggvis.getPlot("plot_id825545188").parseSpec(plot_id825545188_spec);
</script><!--/html_preserve-->

`layer_densities()` 함수에 `fill:="orange"`로 색상 인자로 넘겨 밀도 그래프를 완성한다.


~~~{.r}
mtcars %>% ggvis(~mpg) %>% 
           layer_densities(fill:="orange")
~~~

<!--html_preserve--><div id="plot_id897982248-container" class="ggvis-output-container">
<div id="plot_id897982248" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id897982248_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id897982248" data-renderer="svg">SVG</a>
 | 
<a id="plot_id897982248_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id897982248" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id897982248_download" class="ggvis-download" data-plot-id="plot_id897982248">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id897982248_spec = {
  "data": [
    {
      "name": ".0/density1",
      "format": {
        "type": "csv",
        "parse": {
          "pred_": "number",
          "resp_": "number"
        }
      },
      "values": "\"pred_\",\"resp_\"\n2.96996268656716,0.000114229889951918\n3.12039435177056,0.000137099031165695\n3.27082601697395,0.000163658789299136\n3.42125768217735,0.000194375160187442\n3.57168934738074,0.000230727877524392\n3.72212101258414,0.000272523867967751\n3.87255267778753,0.000320325956556913\n4.02298434299093,0.00037599309625689\n4.17341600819432,0.000439440515352637\n4.32384767339772,0.000511198991536769\n4.47427933860111,0.000593462668518772\n4.62471100380451,0.000686370662623638\n4.7751426690079,0.000790279477575686\n4.9255743342113,0.000907603817871446\n5.07600599941469,0.00103884975835144\n5.22643766461809,0.00118400675125027\n5.37686932982148,0.00134552412738244\n5.52730099502488,0.00152442599662175\n5.67773266022827,0.00172011328096797\n5.82816432543166,0.00193483236491616\n5.97859599063506,0.00217025546340747\n6.12902765583845,0.0024249857972139\n6.27945932104185,0.00270081906592031\n6.42989098624524,0.00300015453572881\n6.58032265144864,0.00332065488384355\n6.73075431665203,0.00366346351861067\n6.88118598185543,0.00403171764486405\n7.03161764705882,0.00442211468498357\n7.18204931226222,0.00483504518568865\n7.33248097746561,0.00527433958234849\n7.48291264266901,0.0057358509200517\n7.6333443078724,0.00621945222608687\n7.7837759730758,0.00672900882562959\n7.93420763827919,0.0072603873072244\n8.08463930348259,0.00781313992097296\n8.23507096868598,0.00839045894842914\n8.38550263388938,0.0089892664724694\n8.53593429909277,0.00960873039167417\n8.68636596429617,0.0102516584708165\n8.83679762949956,0.0109161804803266\n8.98722929470295,0.0116013038634472\n9.13766095990635,0.01230979110756\n9.28809262510974,0.0130411105205615\n9.43852429031314,0.0137942162892095\n9.58895595551653,0.0145720638337131\n9.73938762071993,0.0153755957034034\n9.88981928592332,0.0162035900845954\n10.0402509511267,0.0170591917690394\n10.1906826163301,0.0179449435797094\n10.3411142815335,0.0188590500645277\n10.4915459467369,0.0198045307527742\n10.6419776119403,0.0207855653041188\n10.7924092771437,0.0217991804541393\n10.9428409423471,0.0228476921322685\n11.0932726075505,0.0239367207793146\n11.2437042727539,0.0250614975384111\n11.3941359379573,0.0262229644647495\n11.5445676031607,0.0274275858096822\n11.6949992683641,0.0286684461055459\n11.8454309335675,0.0299449429741924\n11.9958625987708,0.0312622541966149\n12.1462942639742,0.0326125264995686\n12.2967259291776,0.0339933910609557\n12.447157594381,0.0354064933285503\n12.5975892595844,0.0368445745151193\n12.7480209247878,0.0383032379442915\n12.8984525899912,0.0397802866952325\n13.0488842551946,0.0412690252564395\n13.199315920398,0.0427638513533205\n13.3497475856014,0.0442591956721259\n13.5001792508048,0.0457485947820453\n13.6506109160082,0.0472266196642686\n13.8010425812116,0.0486855205107986\n13.951474246415,0.0501185118509567\n14.1019059116184,0.051521992784475\n14.2523375768218,0.0528876766276098\n14.4027692420252,0.054207864437819\n14.5532009072286,0.0554823110400841\n14.703632572432,0.0567038849412507\n14.8540642376353,0.0578635686271433\n15.0044959028387,0.0589654662900363\n15.1549275680421,0.0600049296552133\n15.3053592332455,0.0609715739819571\n15.4557908984489,0.0618740311576331\n15.6062225636523,0.0627108040245639\n15.7566542288557,0.0634704891461074\n15.9070858940591,0.0641655465348584\n16.0575175592625,0.064796908651607\n16.2079492244659,0.0653546836935112\n16.3583808896693,0.065851861363326\n16.5088125548727,0.0662912273886778\n16.6592442200761,0.0666665348545624\n16.8096758852795,0.0669881128555716\n16.9601075504829,0.0672604395880824\n17.1105392156863,0.0674800771814763\n17.2609708808897,0.0676543468236302\n17.4114025460931,0.0677883169899165\n17.5618342112965,0.0678801755563207\n17.7122658764998,0.0679342779584751\n17.8626975417032,0.0679553458756674\n18.0131292069066,0.0679420517332299\n18.16356087211,0.0678959781301018\n18.3139925373134,0.0678210044747698\n18.4644242025168,0.0677155024875742\n18.6148558677202,0.0675784322255718\n18.7652875329236,0.0674129065587844\n18.915719198127,0.0672167350787228\n19.0661508633304,0.0669862793218547\n19.2165825285338,0.0667244905131005\n19.3670141937372,0.0664288782918932\n19.5174458589406,0.0660931487322733\n19.667877524144,0.0657210330744656\n19.8183091893474,0.0653103804734515\n19.9687408545508,0.0648522518137051\n20.1191725197542,0.0643521495478507\n20.2696041849576,0.0638085588775638\n20.420035850161,0.0632116072907701\n20.5704675153644,0.0625678577647767\n20.7208991805677,0.0618769742805211\n20.8713308457711,0.0611306071934516\n21.0217625109745,0.0603348306550085\n21.1721941761779,0.0594914536479482\n21.3226258413813,0.0585945962145538\n21.4730575065847,0.0576496349996038\n21.6234891717881,0.0566606238919742\n21.7739208369915,0.0556246854986451\n21.9243525021949,0.054546477794136\n22.0747841673983,0.0534318907227797\n22.2252158326017,0.0522810425413575\n22.3756474978051,0.0510981271910203\n22.5260791630085,0.0498899939346102\n22.6765108282119,0.048659221308293\n22.8269424934153,0.0474100484431109\n22.9773741586187,0.0461490987270247\n23.1278058238221,0.0448804829967023\n23.2782374890255,0.0436091387067987\n23.4286691542289,0.0423402060492861\n23.5791008194322,0.0410782240178302\n23.7295324846356,0.0398294704674015\n23.879964149839,0.0385965233754998\n24.0303958150424,0.0373833039867859\n24.1808274802458,0.0361979161089547\n24.3312591454492,0.0350396732109352\n24.4816908106526,0.0339114486510522\n24.632122475856,0.0328223056461956\n24.7825541410594,0.0317691680573778\n24.9329858062628,0.030753611798148\n25.0834174714662,0.02978392804134\n25.2338491366696,0.0288565750703016\n25.384280801873,0.0279712847456937\n25.5347124670764,0.0271349665900808\n25.6851441322798,0.0263445232250428\n25.8355757974832,0.025597853221318\n25.9860074626866,0.0249002162130559\n26.13643912789,0.0242495401365685\n26.2868707930934,0.0236421127865399\n26.4373024582967,0.0230815211355204\n26.5877341235001,0.0225669729996276\n26.7381657887035,0.0220934690486721\n26.8885974539069,0.021663035104825\n27.0390291191103,0.0212761275995567\n27.1894607843137,0.0209268027870174\n27.3398924495171,0.020615688921196\n27.4903241147205,0.0203442248079105\n27.6407557799239,0.0201058548814061\n27.7911874451273,0.0198999942831791\n27.9416191103307,0.0197286099597476\n28.0920507755341,0.0195848779132175\n28.2424824407375,0.0194672202300634\n28.3929141059409,0.01937753475414\n28.5433457711443,0.0193091280737112\n28.6937774363477,0.0192599126457736\n28.8442091015511,0.0192304530113981\n28.9946407667545,0.0192152521883013\n29.1450724319579,0.0192118180119851\n29.2955040971612,0.0192189410220036\n29.4459357623646,0.0192326288433402\n29.596367427568,0.0192501834019086\n29.7467990927714,0.0192690613606485\n29.8972307579748,0.0192863035307418\n30.0476624231782,0.0192995195418664\n30.1980940883816,0.019305395672027\n30.348525753585,0.0193015177982812\n30.4989574187884,0.0192863193970955\n30.6493890839918,0.0192563292187651\n30.7998207491952,0.0192092310761116\n30.9502524143986,0.0191447129316464\n31.100684079602,0.0190597159990474\n31.2511157448054,0.0189516815195722\n31.4015474100088,0.0188218177458755\n31.5519790752122,0.0186679215335049\n31.7024107404156,0.0184870148246521\n31.852842405619,0.018281877495053\n32.0032740708223,0.0180514226575714\n32.1537057360257,0.0177922741366815\n32.3041374012291,0.0175086095538923\n32.4545690664325,0.0172005165257554\n32.6050007316359,0.0168644428823687\n32.7554323968393,0.0165055898751256\n32.9058640620427,0.0161248393015937\n33.0562957272461,0.0157196037728915\n33.2067273924495,0.0152948371170419\n33.3571590576529,0.0148521283726792\n33.5075907228563,0.0143905160414946\n33.6580223880597,0.0139139436226405\n33.8084540532631,0.0134246229010725\n33.9588857184665,0.0129230021563104\n34.1093173836699,0.012412149225265\n34.2597490488733,0.0118944906797843\n34.4101807140767,0.0113715294184756\n34.5606123792801,0.0108457339320338\n34.7110440444835,0.0103193004766643\n34.8614757096869,0.00979434886333956\n35.0119073748902,0.00927309076332892\n35.1623390400936,0.00875706968053159\n35.312770705297,0.00824856465538891\n35.4632023705004,0.00774986458226577\n35.6136340357038,0.00726151872935128\n35.7640657009072,0.00678555029972747\n35.9144973661106,0.00632458781956405\n36.064929031314,0.00587797433623721\n36.2153606965174,0.00544715850107212\n36.3657923617208,0.00503525675467915\n36.5162240269242,0.00464035282134964\n36.6666556921276,0.00426313380557409\n36.817087357331,0.0039072221409028\n36.9675190225344,0.0035695510291032\n37.1179506877378,0.00325023019889787\n37.2683823529412,0.00295259974222695\n37.4188140181446,0.00267337529531281\n37.569245683348,0.00241208473572414\n37.7196773485514,0.00217116986485014\n37.8701090137547,0.00194789257119403\n38.0205406789581,0.00174114349490686\n38.1709723441615,0.00155249316706143\n38.3214040093649,0.00137986028677418\n38.4718356745683,0.00122168388841436\n38.6222673397717,0.00107879096933337\n38.7726990049751,0.00094974590071908\n38.9231306701785,0.00083275001516311\n39.0735623353819,0.000728067527532739\n39.2239940005853,0.000634816929717506\n39.3744256657887,0.000551162950225559\n39.5248573309921,0.000476997325756623\n39.6752889961955,0.000411862461092893\n39.8257206613989,0.000354045849314669\n39.9761523266023,0.000303234839565239\n40.1265839918057,0.000259261055085618\n40.2770156570091,0.000220638671355589\n40.4274473222125,0.000186979192758663\n40.5778789874159,0.000158286795672612\n40.7283106526192,0.000133350980396964\n40.8787423178226,0.000111792140133241\n41.029173983026,9.36990176602727e-05\n41.1796056482294,7.81397101722216e-05\n41.3300373134328,6.48141936795621e-05"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.05195895522388\n43.2480410447761"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n-0.00339776729378337\n0.0713531131694508"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "area",
      "properties": {
        "update": {
          "y2": {
            "scale": "y",
            "value": 0
          },
          "fillOpacity": {
            "value": 0.2
          },
          "x": {
            "scale": "x",
            "field": "data.pred_"
          },
          "y": {
            "scale": "y",
            "field": "data.resp_"
          },
          "fill": {
            "value": "orange"
          },
          "stroke": {
            "value": "transparent"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0/density1"
          }
        }
      },
      "from": {
        "data": ".0/density1"
      }
    },
    {
      "type": "line",
      "properties": {
        "update": {
          "stroke": {
            "value": "#000000"
          },
          "x": {
            "scale": "x",
            "field": "data.pred_"
          },
          "y": {
            "scale": "y",
            "field": "data.resp_"
          },
          "fill": {
            "value": "transparent"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0/density1"
          }
        }
      },
      "from": {
        "data": ".0/density1"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "density"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 504,
    "height": 504
  },
  "handlers": null
};
ggvis.getPlot("plot_id897982248").parseSpec(plot_id897982248_spec);
</script><!--/html_preserve-->

`layer_bars()` 함수에 `fill:="orange"`로 색상 인자로 넘겨 막대 그래프를 완성한다.


~~~{.r}
mtcars %>% ggvis(~factor(cyl)) %>% 
           layer_bars(fill:="orange")
~~~

<!--html_preserve--><div id="plot_id254518347-container" class="ggvis-output-container">
<div id="plot_id254518347" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id254518347_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id254518347" data-renderer="svg">SVG</a>
 | 
<a id="plot_id254518347_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id254518347" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id254518347_download" class="ggvis-download" data-plot-id="plot_id254518347">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id254518347_spec = {
  "data": [
    {
      "name": ".0/count1/stack2",
      "format": {
        "type": "csv",
        "parse": {
          "stack_lwr_": "number",
          "stack_upr_": "number"
        }
      },
      "values": "\"x_\",\"stack_lwr_\",\"stack_upr_\"\n\"4\",0,11\n\"6\",0,7\n\"8\",0,14"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {}
      },
      "values": "\"domain\"\n\"4\"\n\"6\"\n\"8\""
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n0\n14.7"
    }
  ],
  "scales": [
    {
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "name": "x",
      "type": "ordinal",
      "points": false,
      "padding": 0.1,
      "sort": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "rect",
      "properties": {
        "update": {
          "stroke": {
            "value": "#000000"
          },
          "fill": {
            "value": "orange"
          },
          "x": {
            "scale": "x",
            "field": "data.x_"
          },
          "y": {
            "scale": "y",
            "field": "data.stack_lwr_"
          },
          "y2": {
            "scale": "y",
            "field": "data.stack_upr_"
          },
          "width": {
            "scale": "x",
            "band": true
          }
        },
        "ggvis": {
          "data": {
            "value": ".0/count1/stack2"
          }
        }
      },
      "from": {
        "data": ".0/count1/stack2"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "factor(cyl)"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "count"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 504,
    "height": 504
  },
  "handlers": null
};
ggvis.getPlot("plot_id254518347").parseSpec(plot_id254518347_spec);
</script><!--/html_preserve-->

### 3. 인터랙티브 상호작용 시각화

`ggvis`에서는 다음 7가지 인터랙티브 상호작용 위젯을 지원한다.

* `input_checkbox()`
* `input_checkboxgroup()`
* `input_numeric()`
* `input_radiobuttons()`
* `input_select()`
* `input_slider()`
* `input_text()`

`input_radiobuttons` 라디오버튼을 사용해서 색상을 인터랙티브하게 변경할 수 있다.


~~~{.r}
mtcars %>% 
  ggvis(~mpg, ~wt,
        fill := input_radiobuttons(label="Choose color:",
                             choices=c("black", "red", "blue", "green"))) %>% 
  layer_points()
~~~



~~~{.output}
Warning: Can't output dynamic/interactive ggvis plots in a knitr document.
Generating a static (non-dynamic, non-interactive) version of the plot.

~~~

<!--html_preserve--><div id="plot_id346438119-container" class="ggvis-output-container">
<div id="plot_id346438119" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id346438119_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id346438119" data-renderer="svg">SVG</a>
 | 
<a id="plot_id346438119_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id346438119" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id346438119_download" class="ggvis-download" data-plot-id="plot_id346438119">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id346438119_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "mpg": "number",
          "wt": "number"
        }
      },
      "values": "\"reactive_360083512\",\"mpg\",\"wt\"\n\"black\",21,2.62\n\"black\",21,2.875\n\"black\",22.8,2.32\n\"black\",21.4,3.215\n\"black\",18.7,3.44\n\"black\",18.1,3.46\n\"black\",14.3,3.57\n\"black\",24.4,3.19\n\"black\",22.8,3.15\n\"black\",19.2,3.44\n\"black\",17.8,3.44\n\"black\",16.4,4.07\n\"black\",17.3,3.73\n\"black\",15.2,3.78\n\"black\",10.4,5.25\n\"black\",10.4,5.424\n\"black\",14.7,5.345\n\"black\",32.4,2.2\n\"black\",30.4,1.615\n\"black\",33.9,1.835\n\"black\",21.5,2.465\n\"black\",15.5,3.52\n\"black\",15.2,3.435\n\"black\",13.3,3.84\n\"black\",19.2,3.845\n\"black\",27.3,1.935\n\"black\",26,2.14\n\"black\",30.4,1.513\n\"black\",15.8,3.17\n\"black\",19.7,2.77\n\"black\",15,3.57\n\"black\",21.4,2.78"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.31745\n5.61955"
    }
  ],
  "scales": [
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "size": {
            "value": 50
          },
          "fill": {
            "field": "data.reactive_360083512"
          },
          "x": {
            "scale": "x",
            "field": "data.mpg"
          },
          "y": {
            "scale": "y",
            "field": "data.wt"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "wt"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 504,
    "height": 504
  },
  "handlers": null
};
ggvis.getPlot("plot_id346438119").parseSpec(plot_id346438119_spec);
</script><!--/html_preserve-->

데이터프레임 변수에서 직접 값을 추출해서 `input_select` 선택값으로 선택하는 것도 가능하다.


~~~{.r}
mtcars %>% 
  ggvis(~mpg, ~wt, fill = input_select(label="Choose fill variable:",
                                      choices=names(mtcars), map=as.name)) %>% 
  layer_points()
~~~



~~~{.output}
Warning: Can't output dynamic/interactive ggvis plots in a knitr document.
Generating a static (non-dynamic, non-interactive) version of the plot.

~~~

<!--html_preserve--><div id="plot_id989713523-container" class="ggvis-output-container">
<div id="plot_id989713523" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id989713523_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id989713523" data-renderer="svg">SVG</a>
 | 
<a id="plot_id989713523_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id989713523" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id989713523_download" class="ggvis-download" data-plot-id="plot_id989713523">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id989713523_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "reactive_720881056": "number",
          "mpg": "number",
          "wt": "number"
        }
      },
      "values": "\"reactive_720881056\",\"mpg\",\"wt\"\n21,21,2.62\n21,21,2.875\n22.8,22.8,2.32\n21.4,21.4,3.215\n18.7,18.7,3.44\n18.1,18.1,3.46\n14.3,14.3,3.57\n24.4,24.4,3.19\n22.8,22.8,3.15\n19.2,19.2,3.44\n17.8,17.8,3.44\n16.4,16.4,4.07\n17.3,17.3,3.73\n15.2,15.2,3.78\n10.4,10.4,5.25\n10.4,10.4,5.424\n14.7,14.7,5.345\n32.4,32.4,2.2\n30.4,30.4,1.615\n33.9,33.9,1.835\n21.5,21.5,2.465\n15.5,15.5,3.52\n15.2,15.2,3.435\n13.3,13.3,3.84\n19.2,19.2,3.845\n27.3,27.3,1.935\n26,26,2.14\n30.4,30.4,1.513\n15.8,15.8,3.17\n19.7,19.7,2.77\n15,15,3.57\n21.4,21.4,2.78"
    },
    {
      "name": "scale/fill",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n10.4\n33.9"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.31745\n5.61955"
    }
  ],
  "scales": [
    {
      "name": "fill",
      "domain": {
        "data": "scale/fill",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": ["#132B43", "#56B1F7"]
    },
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "size": {
            "value": 50
          },
          "fill": {
            "scale": "fill",
            "field": "data.reactive_720881056"
          },
          "x": {
            "scale": "x",
            "field": "data.mpg"
          },
          "y": {
            "scale": "y",
            "field": "data.wt"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [
    {
      "orient": "right",
      "fill": "fill",
      "title": "reactive_720881056"
    }
  ],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "wt"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 504,
    "height": 504
  },
  "handlers": null
};
ggvis.getPlot("plot_id989713523").parseSpec(plot_id989713523_spec);
</script><!--/html_preserve-->

### 4. `ggvis` 범례와 축서식 

`add_legend()` 함수를 통해 범례를 추가하고, `add_axis()` 함수를 통해 축서식을 설정한다.


~~~{.r}
mtcars %>% 
  ggvis(~mpg, ~wt, opacity := 0.6, 
        fill = ~factor(cyl))  %>%
  layer_points() %>%
  add_legend(c("fill"), title="실린더 유형") %>%
  add_axis("x", title = "Weight(차체 중량)")
~~~

<!--html_preserve--><div id="plot_id642770714-container" class="ggvis-output-container">
<div id="plot_id642770714" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id642770714_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id642770714" data-renderer="svg">SVG</a>
 | 
<a id="plot_id642770714_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id642770714" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id642770714_download" class="ggvis-download" data-plot-id="plot_id642770714">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id642770714_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "mpg": "number",
          "wt": "number"
        }
      },
      "values": "\"factor(cyl)\",\"mpg\",\"wt\"\n\"6\",21,2.62\n\"6\",21,2.875\n\"4\",22.8,2.32\n\"6\",21.4,3.215\n\"8\",18.7,3.44\n\"6\",18.1,3.46\n\"8\",14.3,3.57\n\"4\",24.4,3.19\n\"4\",22.8,3.15\n\"6\",19.2,3.44\n\"6\",17.8,3.44\n\"8\",16.4,4.07\n\"8\",17.3,3.73\n\"8\",15.2,3.78\n\"8\",10.4,5.25\n\"8\",10.4,5.424\n\"8\",14.7,5.345\n\"4\",32.4,2.2\n\"4\",30.4,1.615\n\"4\",33.9,1.835\n\"4\",21.5,2.465\n\"8\",15.5,3.52\n\"8\",15.2,3.435\n\"8\",13.3,3.84\n\"8\",19.2,3.845\n\"4\",27.3,1.935\n\"4\",26,2.14\n\"4\",30.4,1.513\n\"8\",15.8,3.17\n\"6\",19.7,2.77\n\"8\",15,3.57\n\"4\",21.4,2.78"
    },
    {
      "name": "scale/fill",
      "format": {
        "type": "csv",
        "parse": {}
      },
      "values": "\"domain\"\n\"4\"\n\"6\"\n\"8\""
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.31745\n5.61955"
    }
  ],
  "scales": [
    {
      "name": "fill",
      "type": "ordinal",
      "domain": {
        "data": "scale/fill",
        "field": "data.domain"
      },
      "points": true,
      "sort": false,
      "range": "category10"
    },
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "size": {
            "value": 50
          },
          "fill": {
            "scale": "fill",
            "field": "data.factor(cyl)"
          },
          "opacity": {
            "value": 0.6
          },
          "x": {
            "scale": "x",
            "field": "data.mpg"
          },
          "y": {
            "scale": "y",
            "field": "data.wt"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [
    {
      "orient": "right",
      "title": "실린더 유형",
      "fill": "fill"
    }
  ],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "title": "Weight(차체 중량)",
      "layer": "back",
      "grid": true
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "wt"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 504,
    "height": 504
  },
  "handlers": null
};
ggvis.getPlot("plot_id642770714").parseSpec(plot_id642770714_spec);
</script><!--/html_preserve-->

~~~{.r}
  add_axis("y", title = "연비(mpg")
~~~



~~~{.output}
Error in vis$cur_vis: $ operator is invalid for atomic vectors

~~~

### 5. `ggvis` 척도(scale)

`ggvis` 척도를 다음 함수 5개를 사용해서 설정한다.

* `scale_datetime()`
* `scale_logical()`
* `scale_nominal()`
* `scale_numeric()`
* `scale_singular()`


~~~{.r}
mtcars %>% 
  ggvis(~wt, ~mpg, fill = ~disp, stroke = ~disp, strokeWidth := 2) %>%
  layer_points() %>%
  scale_numeric("fill", range = c("red", "yellow"))
~~~

<!--html_preserve--><div id="plot_id715352388-container" class="ggvis-output-container">
<div id="plot_id715352388" class="ggvis-output"></div>
<div class="plot-gear-icon">
<nav class="ggvis-control">
<a class="ggvis-dropdown-toggle" title="Controls" onclick="return false;"></a>
<ul class="ggvis-dropdown">
<li>
Renderer: 
<a id="plot_id715352388_renderer_svg" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id715352388" data-renderer="svg">SVG</a>
 | 
<a id="plot_id715352388_renderer_canvas" class="ggvis-renderer-button" onclick="return false;" data-plot-id="plot_id715352388" data-renderer="canvas">Canvas</a>
</li>
<li>
<a id="plot_id715352388_download" class="ggvis-download" data-plot-id="plot_id715352388">Download</a>
</li>
</ul>
</nav>
</div>
</div>
<script type="text/javascript">
var plot_id715352388_spec = {
  "data": [
    {
      "name": ".0",
      "format": {
        "type": "csv",
        "parse": {
          "disp": "number",
          "wt": "number",
          "mpg": "number"
        }
      },
      "values": "\"disp\",\"wt\",\"mpg\"\n160,2.62,21\n160,2.875,21\n108,2.32,22.8\n258,3.215,21.4\n360,3.44,18.7\n225,3.46,18.1\n360,3.57,14.3\n146.7,3.19,24.4\n140.8,3.15,22.8\n167.6,3.44,19.2\n167.6,3.44,17.8\n275.8,4.07,16.4\n275.8,3.73,17.3\n275.8,3.78,15.2\n472,5.25,10.4\n460,5.424,10.4\n440,5.345,14.7\n78.7,2.2,32.4\n75.7,1.615,30.4\n71.1,1.835,33.9\n120.1,2.465,21.5\n318,3.52,15.5\n304,3.435,15.2\n350,3.84,13.3\n400,3.845,19.2\n79,1.935,27.3\n120.3,2.14,26\n95.1,1.513,30.4\n351,3.17,15.8\n145,2.77,19.7\n301,3.57,15\n121,2.78,21.4"
    },
    {
      "name": "scale/fill",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n71.1\n472"
    },
    {
      "name": "scale/stroke",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n71.1\n472"
    },
    {
      "name": "scale/x",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n1.31745\n5.61955"
    },
    {
      "name": "scale/y",
      "format": {
        "type": "csv",
        "parse": {
          "domain": "number"
        }
      },
      "values": "\"domain\"\n9.225\n35.075"
    }
  ],
  "scales": [
    {
      "domain": {
        "data": "scale/fill",
        "field": "data.domain"
      },
      "name": "fill",
      "range": ["red", "yellow"],
      "zero": false,
      "nice": false,
      "clamp": false
    },
    {
      "name": "stroke",
      "domain": {
        "data": "scale/stroke",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": ["#132B43", "#56B1F7"]
    },
    {
      "name": "x",
      "domain": {
        "data": "scale/x",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "width"
    },
    {
      "name": "y",
      "domain": {
        "data": "scale/y",
        "field": "data.domain"
      },
      "zero": false,
      "nice": false,
      "clamp": false,
      "range": "height"
    }
  ],
  "marks": [
    {
      "type": "symbol",
      "properties": {
        "update": {
          "size": {
            "value": 50
          },
          "fill": {
            "scale": "fill",
            "field": "data.disp"
          },
          "stroke": {
            "scale": "stroke",
            "field": "data.disp"
          },
          "strokeWidth": {
            "value": 2
          },
          "x": {
            "scale": "x",
            "field": "data.wt"
          },
          "y": {
            "scale": "y",
            "field": "data.mpg"
          }
        },
        "ggvis": {
          "data": {
            "value": ".0"
          }
        }
      },
      "from": {
        "data": ".0"
      }
    }
  ],
  "legends": [
    {
      "orient": "right",
      "fill": "fill",
      "title": "disp"
    },
    {
      "orient": "right",
      "stroke": "stroke",
      "title": "disp"
    }
  ],
  "axes": [
    {
      "type": "x",
      "scale": "x",
      "orient": "bottom",
      "layer": "back",
      "grid": true,
      "title": "wt"
    },
    {
      "type": "y",
      "scale": "y",
      "orient": "left",
      "layer": "back",
      "grid": true,
      "title": "mpg"
    }
  ],
  "padding": null,
  "ggvis_opts": {
    "keep_aspect": false,
    "resizable": true,
    "padding": {},
    "duration": 250,
    "renderer": "svg",
    "hover_duration": 0,
    "width": 504,
    "height": 504
  },
  "handlers": null
};
ggvis.getPlot("plot_id715352388").parseSpec(plot_id715352388_spec);
</script><!--/html_preserve-->
