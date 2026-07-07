let default_resume = "source/resume.org"

type format = Markdown | Org

let format_of path =
  match String.lowercase_ascii (Filename.extension path) with
  | ".org" -> Org
  | _ -> Markdown

let read path =
  let ic = open_in path in
  let len = in_channel_length ic in
  let buf = Bytes.create len in
  really_input ic buf 0 len;
  close_in ic;
  Bytes.to_string buf

let markdown_to_html markdown =
  markdown |> Omd.of_string |> Omd.to_html

let run_cmd cmd =
  match Sys.command cmd with
  | 0 -> Ok ()
  | code -> Error (Printf.sprintf "command failed with exit code %d" code)

let with_temp_file prefix suffix f =
  let path = Filename.temp_file prefix suffix in
  Fun.protect
    ~finally:(fun () ->
      if Sys.file_exists path then Sys.remove path)
    (fun () -> f path)

let pandoc_to_file ~input_path ~output_path =
  let cmd =
    Printf.sprintf "pandoc %s -o %s"
      (Filename.quote input_path)
      (Filename.quote output_path)
  in
  run_cmd cmd

let html_via_pandoc resume_path =
  with_temp_file "cv" ".html" (fun output_path ->
      match pandoc_to_file ~input_path:resume_path ~output_path with
      | Error _ as err -> err
      | Ok () -> Ok (read output_path))

let html_of_resume resume_path content =
  match format_of resume_path with
  | Markdown -> Ok (markdown_to_html content)
  | Org -> html_via_pandoc resume_path

let html_page body =
  Printf.sprintf
    {|<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <title>Arulselvan Madhavan — CV</title>
  <link rel="stylesheet" href="/style.css"/>
  <link rel="stylesheet" href="/cv.css"/>
</head>
<body class="cv-page">
  <header class="cv-toolbar">
    <div class="container">
      <a href="/" class="cv-back">← Portfolio</a>
      <a href="/cv.pdf" class="btn btn-primary" download>Download PDF</a>
    </div>
  </header>
  <main class="container cv-content">
%s
  </main>
</body>
</html>
|}
    body

let pdf_header = "source/cv-pdf.tex"

let write_pdf ~resume_path ~output_path =
  if not (Sys.file_exists resume_path) then
    Error (Printf.sprintf "resume not found: %s" resume_path)
  else
    let header =
      if Sys.file_exists pdf_header then
        Printf.sprintf "--include-in-header=%s " (Filename.quote pdf_header)
      else ""
    in
    let cmd =
      Printf.sprintf
        "pandoc %s -o %s --pdf-engine=pdflatex %s-V mainfontsize=8pt -V \
         geometry:margin=0.35in -V linestretch=0.85 -V colorlinks=true -V \
         linkcolor=blue -V urlcolor=blue -V papersize=letter"
        (Filename.quote resume_path)
        (Filename.quote output_path)
        header
    in
    run_cmd cmd

let generate ~resume_path ~output_dir =
  if not (Sys.file_exists resume_path) then
    Error (Printf.sprintf "resume not found: %s" resume_path)
  else
    let content = read resume_path in
    let html_path = Filename.concat output_dir "cv.html" in
    let pdf_path = Filename.concat output_dir "cv.pdf" in
    (match html_of_resume resume_path content with
    | Ok body ->
        let oc = open_out html_path in
        output_string oc (html_page body);
        close_out oc
    | Error msg ->
        prerr_endline
          ("Warning: could not generate CV HTML — " ^ msg
          ^ " (pandoc is required for .org sources)"));
    (match write_pdf ~resume_path ~output_path:pdf_path with
    | Ok () -> Ok ()
    | Error msg ->
        if Sys.file_exists pdf_path then Sys.remove pdf_path;
        Error (Printf.sprintf "could not generate PDF — %s" msg))
