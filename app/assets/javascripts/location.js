function Location(resp){
  this.name = resp.name;
  this.location = resp.location;
  this.description = resp.description;
  this.img_url = resp.img_url;
  this.reviews = resp.reviews;
}

Location.prototype.display = function(){

  $('#display').append(`
    <p>Location Name:${this.name}
    <br>Description:${this.description}
    <br>Location:${this.location}
    <br>Reviews:${this.reviews.map(review => `<br>${review.comment}`).join('')}
  `)
}

$(document).on('click', '#show_location', function (event) {
    event.preventDefault();
    var c=$(this).val()
  //    alert(c);

     $.get(`/locations/${c}`).done(function(resp){
      //  $(this).append(resp)
         let  result = new Location(resp);
         result.display();// call to prototype function


        })
  })

// Following Ajax will take care of showing reviews
  $(document).on('click', '#show_reviews', function (event) {
      event.preventDefault();
       var currentId = $(this).val();


       $.get(`/locations/${currentId}/reviews`).done(function(resp){

   $('#reviews_index').append(`
     ${resp.map(el=> `<br>${el.comment}`).join('')}
       `)
          })
    })

  $(document).on('submit', '#new_review', function (event) {
      event.preventDefault();
      var c=$('#review_location_id').val();
      var formdata =$(this).serialize();
      var formfields = this;

      alert(c)
       $.ajax(
         {
           type: "POST",
           url:'/reviews',
           data: formdata
         }).done(function(resp){
             $(`#reviews ol`).append(`<li>Comment:${resp.comment}<br>Ratings:${resp.ratings}</li>`)
               formfields.reset();

          })
    })
