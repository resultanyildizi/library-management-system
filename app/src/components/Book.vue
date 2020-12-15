<template>
  <li style="transform: scale(0.8)">
    <figure class="book">
      <!-- Front -->

      <ul class="hardcover_front">
        <li>
          <img
            src="@/assets/img/cover1.jpg"
            alt=""
            width="100%"
            height="100%"
          />
        </li>
        <li></li>
      </ul>

      <!-- Pages -->
      <ul class="page">
        <li></li>
        <li class="text-center">
          <a class="btn" href="#">Ödünç Ver</a>
        </li>
        <li></li>
        <li></li>
        <li></li>
      </ul>

      <!-- Back -->

      <ul class="hardcover_back">
        <li></li>
        <li></li>
      </ul>
      <ul class="book_spine">
        <li></li>
        <li></li>
      </ul>
      <figcaption>
        <h1>Papelucho Perdido</h1>
        <span>By Marcela Paz</span>
        <p>
          Şişli’deki üç katlı pembe binanın perdeleri sıkı sıkıya kapalıydı. Gaz
          lambasının cılız ışığı, odayı hayal meyal aydınlatıyordu. Altı
          kişiydiler. Üzerine harita yayılmış masanın etrafında, ayaktaydılar.
          Talihsiz bir kuşağın çocuklarıydılar... ”
        </p>
      </figcaption>
    </figure>
  </li>
</template>

<script>
export default {
  name: "Book",
};
</script>

<style>
</style>