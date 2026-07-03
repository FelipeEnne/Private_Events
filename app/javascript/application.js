import "@hotwired/turbo-rails"
import jquery from "jquery"
import "bootstrap"
import "./channels"

window.jQuery = jquery
window.$ = jquery

document.addEventListener("turbo:load", () => {
  $("#nav-your-event-tab.nav-link").on("click", function () {
    $(".event-title").text("Managed Events")
  })
  $("#nav-accepted-event-tab.nav-link").on("click", function () {
    $(".event-title").text("Invited Events")
  })

  const search = $(location).attr("search")
  const pathname = $(location).attr("pathname")

  if (search === "?type=past_events") {
    $(".past-link").addClass("active")
    $(".upcoming-link").removeClass("active")
  } else if (
    search === "?type=upcoming_events" ||
    pathname === "/dashboard" ||
    pathname === "/events"
  ) {
    $(".upcoming-link").addClass("active")
    $(".past-link").removeClass("active")
  }
})
