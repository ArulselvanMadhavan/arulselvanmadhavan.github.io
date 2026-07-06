open Cmdliner
open Portfolio_lib

let copy_file src dst =
  let ic = open_in_bin src in
  let oc = open_out_bin dst in
  let buffer = Bytes.create 65536 in
  let rec loop () =
    let n = input ic buffer 0 (Bytes.length buffer) in
    if n = 0 then ()
    else (
      output oc buffer 0 n;
      loop ())
  in
  loop ();
  close_in ic;
  close_out oc

let ensure_dir path =
  if not (Sys.file_exists path) then Unix.mkdir path 0o755

let rec ensure_parent_dir path =
  let parent = Filename.dirname path in
  if parent <> "." && parent <> "/" && not (Sys.file_exists parent) then (
    ensure_parent_dir parent;
    Unix.mkdir parent 0o755)

let write_file path content =
  ensure_parent_dir path;
  let oc = open_out path in
  output_string oc content;
  close_out oc

let rec copy_static src_dir dst_dir =
  if Sys.file_exists src_dir then (
    let entries = Sys.readdir src_dir in
    ensure_dir dst_dir;
    Array.iter
      (fun name ->
        let src = Filename.concat src_dir name
        and dst = Filename.concat dst_dir name in
        if Sys.is_directory src then copy_static src dst else copy_file src dst)
      entries)

let build output_dir static_dir resume_path =
  ensure_dir output_dir;
  (match Cv.generate ~resume_path ~output_dir with
  | Ok () -> ()
  | Error msg -> failwith msg);
  let html =
    Render.to_string (Render.page Content.profile Content.open_source)
  in
  write_file (Filename.concat output_dir "index.html") html;
  copy_static static_dir output_dir

let output_dir =
  let doc = "Output directory for generated site." in
  Arg.(value & pos 0 string "_site" &info [] ~docv:"DIR" ~doc)

let static_dir =
  let doc = "Directory containing static assets (CSS, etc.)." in
  Arg.(value & opt string "static" &info [ "s"; "static" ] ~docv:"DIR" ~doc)

let resume_path =
  let doc = "Path to resume source in source/ (.org or .md)." in
  Arg.(
    value
    & opt string Cv.default_resume
    & info [ "r"; "resume" ] ~docv:"FILE" ~doc)

let () =
  let cmd =
    let doc = "Generate the portfolio static website." in
    let sdocs = Manpage.s_common_options in
    Cmd.v (Cmd.info "portfolio" ~doc ~sdocs)
      (Term.(const build $ output_dir $ static_dir $ resume_path))
  in
  exit (Cmd.eval cmd)
