

function Location(resp){
  this.name = resp.name;
  this.location = resp.location;
  this.description = resp.description;
  this.img_url = resp.img_url;
  this.reviews = resp.reviews;
}

Location.prototype.display = function(){
document.getElementById('container').innerHTML = ""
  $('#container').append(`
    <h3>
    ${this.name}
    </h3>

    <br>Description:${this.description}
    <br>Location:${this.location}
    <h4><b>Reviews:</b></h4>

    <ol>
    ${this.reviews.map(review => `<li>${review.comment}</li>`).join('')}
    </ol>
  `)
}
//Following JS will take care of appending a location details in the bottom of the page
$(document).on('click', '#show_location', function (event) {
    event.preventDefault();
    var locationId = $(this).val()
    $.get(`/locations/${locationId}`).done(function(resp){
    let  result = new Location(resp);
    result.display();// call to prototype function
      })
  })

// Following Ajax will take care of showing reviews

  $(document).on('click', '#show_reviews', function (event) {
      event.preventDefault();
      document.getElementById('container').innerHTML = ""
      let currentId = $(this).val();

        $.get(`/locations/${currentId}/reviews`).done(function(resp){
          let average = resp.reduce((a,b)=>{ return a+b.ratings},0)/resp.length;
          $('#container').append(`
            <h4>Average Ratings:${Math.floor(average)}</h4>
        <h3>All Reviews </h3><ol>
      ${resp.map(el=> `<li>${el.comment} with a rating of ${el.ratings}</li>`).join('')}
</ol>
        `)
          })
    })

//following js will create a new review and append it on the record

  $(document).on('submit', '#new_review', function (event) {
      event.preventDefault();
      var locationId =$('#review_location_id').val();
      var formdata =$(this).serialize();
      var formfields = this;

       $.ajax(
         {
           type: "POST",
           url:'/reviews',
           data: formdata
         }).done(function(review){

             $(`#reviews_${review.location_id} ol`).append(`
               <li>
               Comment:${review.comment}
                Ratings:${review.ratings}
               </li>`);

               formfields.reset();

          })
    })

$(document).on('click',"#hideform",function(event){
  event.preventDefault();
  $('#new_location').hide();
  $('#hideform').hide();

})

$(document).on("click","#clearAll",function(event){
  $('#displayol').innerHTML=""
})
