open Tyxml
open Html

let css_href = "/style.css"
let cv_html_href = "/cv.html"
let cv_pdf_href = "/cv.pdf"

let ext_link ~href text =
  a
    ~a:[ a_href href; a_target "_blank"; a_rel [ `Nofollow; `Noopener ] ]
    [ txt text ]

let render_skills skills =
  div ~a:[ a_class [ "skills-grid" ] ]
  @@ List.map
       (fun { Content.category; items } ->
         div ~a:[ a_class [ "skill-card" ] ]
           [
             h3 [ txt category ];
             ul
               (List.map
                  (fun item -> li [ span ~a:[ a_class [ "skill-tag" ] ] [ txt item ] ])
                  items);
           ])
       skills

let render_timeline_item
    { Content.title; org; period; highlights; links } =
  let links_section =
    match links with
    | [] -> []
    | links ->
        [
          div ~a:[ a_class [ "timeline-links" ] ]
            (List.map
               (fun (label, url) -> ext_link ~href:url label)
               links);
        ]
  in
  article ~a:[ a_class [ "timeline-item" ] ]
    [
      div ~a:[ a_class [ "timeline-marker" ] ] [];
      div ~a:[ a_class [ "timeline-content" ] ]
        (
          [
            div ~a:[ a_class [ "timeline-header" ] ]
              [
                h3 [ txt title ];
                span ~a:[ a_class [ "org" ] ] [ txt org ];
                time ~a:[ a_datetime period ] [ txt period ];
              ];
            ul
              (List.map
                 (fun h -> li [ txt h ])
                 highlights);
          ]
          @ links_section);
    ]

let render_open_source projects =
  div ~a:[ a_class [ "oss-grid" ] ]
  @@ List.map
       (fun (name, desc, url) ->
         article ~a:[ a_class [ "oss-card" ] ]
           [
             h3 [ ext_link ~href:url name ];
             p [ txt desc ];
           ])
       projects

let page profile open_source =
  let cv_actions =
    div ~a:[ a_class [ "hero-actions" ] ]
      [
        a ~a:[ a_href cv_html_href; a_class [ "btn"; "btn-secondary" ] ]
          [ txt "View CV" ];
        a
          ~a:[ a_href cv_pdf_href; a_class [ "btn"; "btn-primary" ]; a_download None ]
          [ txt "Download CV (PDF)" ];
      ]
  in
  html
    (head
       (title (txt (profile.Content.name ^ " — Portfolio")))
       [
         meta ~a:[ a_charset "utf-8" ] ();
         meta
           ~a:
             [ a_name "viewport"; a_content "width=device-width, initial-scale=1" ]
           ();
         link ~rel:[ `Stylesheet ] ~href:css_href ();
       ])
    (body
       [
         header ~a:[ a_class [ "site-header" ] ]
           [
             div ~a:[ a_class [ "container" ] ]
               [
                 div ~a:[ a_class [ "hero" ] ]
                   [
                     h1 [ txt profile.name ];
                     p ~a:[ a_class [ "tagline" ] ] [ txt profile.tagline ];
                     p ~a:[ a_class [ "location" ] ] [ txt profile.location ];
                     nav ~a:[ a_class [ "contact-links" ] ]
                       [
                         ext_link ~href:("mailto:" ^ profile.email) profile.email;
                         ext_link ~href:profile.linkedin "LinkedIn";
                         ext_link ~href:profile.github "GitHub";
                         ext_link ~href:profile.scholar "Google Scholar";
                       ];
                     cv_actions;
                   ];
               ];
           ];
         main ~a:[ a_class [ "container" ] ]
           [
             section ~a:[ a_id "skills"; a_class [ "section" ] ]
               [
                 h2 [ txt "Skills" ];
                 p ~a:[ a_class [ "section-intro" ] ]
                   [
                     txt
                       "A snapshot of the technologies and tools behind the work \
                        highlighted in this portfolio.";
                   ];
                 render_skills profile.skills;
               ];
             section ~a:[ a_id "timeline"; a_class [ "section" ] ]
               [
                 h2 [ txt "Timeline" ];
                 p ~a:[ a_class [ "section-intro" ] ]
                   [ txt "Professional experience and education, most recent first." ];
                 div ~a:[ a_class [ "timeline" ] ]
                   (List.map render_timeline_item profile.timeline);
               ];
             section ~a:[ a_id "open-source"; a_class [ "section" ] ]
               [
                 h2 [ txt "Open Source" ];
                 p ~a:[ a_class [ "section-intro" ] ]
                   [ txt "Selected projects and contributions." ];
                 render_open_source open_source;
               ];
           ];
       ])

let to_string doc = Format.asprintf "%a" (pp ()) doc
