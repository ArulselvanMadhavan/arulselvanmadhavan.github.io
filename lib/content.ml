type skill_group = { category : string; items : string list }

type achievement = {
  title : string;
  org : string;
  period : string;
  highlights : string list;
  links : (string * string) list;
}

type profile = {
  name : string;
  tagline : string;
  location : string;
  email : string;
  phone : string;
  linkedin : string;
  github : string;
  scholar : string;
  skills : skill_group list;
  timeline : achievement list;
}

let profile =
  {
    name = "Arulselvan Madhavan";
    tagline = "Machine Systems Engineer · ML Performance · Functional Programming";
    location = "San Francisco, California";
    email = "arulselvan1234@gmail.com";
    phone = "(650) 336-3892";
    linkedin = "https://www.linkedin.com/in/arulselvanmadhavan";
    github = "https://github.com/ArulselvanMadhavan";
    scholar = "https://scholar.google.com/citations?hl=en&user=8r4bPwQAAAAJ";
    skills =
      [
        {
          category = "Languages";
          items =
            [
              "Scala"; "Go"; "Python"; "OCaml"; "JavaScript"; "C++"; "C";
              "Haskell"; "Fortran";
            ];
        };
        {
          category = "Parallel Frameworks";
          items = [ "OpenMP"; "MPI"; "CUDA" ];
        };
        {
          category = "Visualization";
          items = [ "React"; "Vega"; "Panel"; "HoloViews"; "Bonsai" ];
        };
        {
          category = "Performance Tools";
          items = [ "pprof"; "likwid"; "perf"; "flamegraph"; "HPC@Cori" ];
        };
      ];
    timeline =
      [
        {
          title = "Machine Systems Engineer";
          org = "LightMatter, Mountain View";
          period = "July 2022 – Present";
          highlights =
            [
              "Built an analytical and event-driven simulator for data-center ML \
               training and inference with optical interconnects.";
              "Primary contributor to a PyTorch extension simulating analog matrix \
               multiplications on photonic hardware with adaptive quantization.";
              "Built quantviz for reduced bit-width quantization (FP8, VS-quant) \
               with calibration support.";
              "Authored opine, an open-source OCaml library for large-scale Python \
               source-code transformations.";
              "Implemented mini-dalle and Stable Diffusion in OCaml.";
            ];
          links =
            [
              ( "Nature publication",
                "https://www.nature.com/articles/s41586-025-08854-x" );
              ("quantviz", "https://github.com/ArulselvanMadhavan/quantviz");
              ("opine", "https://github.com/ArulselvanMadhavan/opine");
              ( "mini-dalle",
                "https://github.com/ArulselvanMadhavan/mini_dalle" );
              ( "Stable Diffusion OCaml",
                "https://github.com/ArulselvanMadhavan/diffusers-ocaml" );
            ];
        };
        {
          title = "Performance Engineer";
          org = "Chartboost, San Francisco";
          period = "Sep 2020 – July 2022";
          highlights =
            [
              "Optimized ML inference (linear, DNN) with compression; hash maps \
               under 20 ms.";
              "Built a low-latency real-time bidder in Go handling 500K \
               requests/sec in under 30 ms.";
              "Built a distributed key-value store with terabytes of data and \
               read latency under 10 ms.";
              "Built ML training pipelines for production deployment.";
              "Built CPU and memory observability tools to catch performance \
               regressions.";
            ];
          links = [];
        };
        {
          title = "Senior Software Engineer";
          org = "Chartboost, San Francisco";
          period = "March 2018 – Sep 2020";
          highlights =
            [
              "Built a high-throughput AdExchange conducting real-time auctions \
               at 100K req/sec.";
              "Built a low-latency real-time ad scoring service at 50 ms/request.";
              "Led efforts to promote typed functional programming and category \
               theory among engineers.";
            ];
          links =
            [
              ( "Engineering blog",
                "https://medium.com/@arulselvan1234" );
            ];
        };
        {
          title = "Software Engineer 2";
          org = "Intuit, Mountain View";
          period = "January 2017 – March 2018";
          highlights =
            [
              "Designed and implemented encoding of US tax regulations for all 50 \
               states, used by 200K+ QuickBooks subscribers.";
            ];
          links = [];
        };
        {
          title = "Software Developer Intern";
          org = "Intuit, Mountain View";
          period = "June 2016 – August 2016";
          highlights =
            [
              "Front-end developer for QuickBooks payroll: UX research and \
               responsive interfaces.";
            ];
          links = [];
        };
        {
          title = "Software Developer Co-op";
          org = "Intuit, Cambridge";
          period = "July 2015 – December 2015";
          highlights =
            [
              "Primary backend developer for web services connecting to \
               non-relational data sources with SQL-like query support.";
            ];
          links = [];
        };
        {
          title = "Systems Engineer";
          org = "Tata Consultancy Services, India";
          period = "December 2011 – August 2014";
          highlights =
            [
              "Primary developer on internal tools team researching and building \
               software to automate engineering workflows.";
            ];
          links = [];
        };
        {
          title = "M.S. Computer Science";
          org = "Northeastern University, Boston";
          period = "September 2014 – December 2016";
          highlights = [ "GPA 3.8" ];
          links = [];
        };
      ];
  }

let open_source =
  [
    ( "Opine",
      "Python AST unparser in OCaml for source-code transformations.",
      "https://github.com/ArulselvanMadhavan/opine" );
    ( "Stable Diffusion 1.4",
      "OCaml implementation of Stable Diffusion.",
      "https://github.com/ArulselvanMadhavan/diffusers-ocaml" );
    ( "mini-dalle",
      "OCaml implementation of the mini-DALL·E inference path.",
      "https://github.com/ArulselvanMadhavan/mini_dalle" );
    ( "Tsunami Simulation",
      "GPU programming (OpenMP + OpenMPI) on HPC@Cori.",
      "https://github.com/ArulselvanMadhavan/csc746/tree/master/tsunami" );
    ( "Category Theory for Programmers — OCaml edition",
      "Primary contributor.",
      "https://github.com/hmemcpy/milewski-ctfp-pdf/releases/tag/v1.4.0-rc1" );
    ( "Scala-steward",
      "Contributed private-repo support.",
      "https://github.com/fthomas/scala-steward#contributors" );
    ( "Scala talks YouTube channel",
      "Educational content on Scala and FP.",
      "https://www.youtube.com/channel/UCwAxoFPbO9XHT3l698qjO-Q" );
  ]
