---
title: "A weighted residual bootstrap method for multilevel modeling with sampling weights"
authors:
- Wen Luo and Mark H. C. Lai
date: "2021-12-29T00:00:00Z"
doi: "10.35566/jbds/v1n2/p6"

# Schedule page publish date (NOT publication's date).
publishDate: "2021-12-13T00:00:00Z"

# Publication type.
# Legend: 0 = Uncategorized; 1 = Conference paper; 2 = Journal article;
# 3 = Preprint / Working Paper; 4 = Report; 5 = Book; 6 = Book section;
# 7 = Thesis; 8 = Patent
publication_types: ["2"]

# Publication name and optional abbreviated publication name.
publication: "*Journal of Behavioral Data Science, 1(2)*, 89--118"
publication_short: ""

abstract: "Multilevel modeling is often used to analyze survey data collected with a multistage sampling design. When the selection is informative, sampling weights need to be incorporated in the estimation. We propose a weighted residual bootstrap method as an alternative to the multilevel pseudo-maximum likelihood (MPML) estimators. In a Monte Carlo simulation using two-level linear mixed effects models, the bootstrap method showed advantages over MPML for the estimates and the statistical inferences of the intercept, the slope of the level-2 predictor, and the variance components at level-2. The impact of sample size, selection mechanism, intraclass correlation (ICC), and distributional assumptions on the performance of the methods were examined. The performance of MPML was suboptimal when sample size and ICC were small and when the normality assumption was violated. The bootstrap estimates performed generally well across all the simulation conditions, but had notably suboptimal performance in estimating the covariance component in a random slopes model when sample size and ICCs were large. As an illustration, the bootstrap method is applied to the American data of the OECD's Program for International Students Assessment (PISA) survey on math achievement using the R package bootmlm."

# Summary. An optional shortened abstract.
summary: We propose a weighted residual bootstrap method as an alternative to the multilevel pseudo-maximum likelihood (MPML) estimators.. 

tags:
- bootstrap
- sampling weights
- multilevel modeling
featured: false

links:
- name: "View journal article"
  url: "https://jbds.isdsa.org/index.php/jbds/article/view/30"
url_pdf: 'https://jbds.isdsa.org/index.php/jbds/article/view/30/33'
url_code: ''
url_dataset: ''
url_poster: ''
url_project: ''
url_slides: ''
url_source: ''
url_video: ''

# Featured image
# To use, add an image named `featured.jpg/png` to your page's folder. 
image:
  caption: ""
  focal_point: "Smart"
  preview_only: false

# Associated Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter your project's folder or file name without extension.
#   E.g. `internal-project` references `content/project/internal-project/index.md`.
#   Otherwise, set `projects: []`.
# projects: [""]

# Slides (optional).
#   Associate this publication with Markdown slides.
#   Simply enter your slide deck's filename without extension.
#   E.g. `slides: "example"` references `content/slides/example/index.md`.
#   Otherwise, set `slides: ""`.
# slides: example
---

<!--

Supplementary notes can be added here, including [code and math](https://sourcethemes.com/academic/docs/writing-markdown-latex/).

-->
