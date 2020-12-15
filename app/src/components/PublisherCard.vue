<template>
  <div class="news-card">
    <a href="#" class="news-card__card-link"></a>
    <img
      :src="
        !!image
          ? require(`../../upload/img/${image}`)
          : 'https://images.unsplash.com/photo-1532123675048-773bd75df1b4?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60'
      "
      alt=""
      class="news-card__image"
    />
    <div class="news-card__text-wrapper">
      <h2 class="news-card__title">{{ name }}</h2>
      <div class="news-card__post-date">
        {{ foundationYearTrim }}
      </div>

      <div v-if="description != '---'" class="news-card__details-wrapper">
        <p class="news-card__excerpt">{{ description.substring(0, 100) }}...</p>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "PublisherCard",
  props: {
    name: {
      type: String,
      required: true,
    },
    foundationYear: {
      type: String,
      required: true,
    },
    description: {
      type: String,
    },
    image: {
      type: String,
    },
  },
  created() {
    console.log(this.image);
  },
  computed: {
    foundationYearTrim() {
      return this.foundationYear.substring(0, 4);
    },
  },
};
</script>

<style>
.v-sheet.v-card {
  cursor: pointer;
}
</style>
<style scoped src="@/assets/css/mycard.css"></style>
