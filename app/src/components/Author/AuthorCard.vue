<template>
  <div class="card">
    <div class="card-image">
      <img :src="require(`../../../upload/img/${image}`)" alt="profile one" />
    </div>

    <div class="details">
      <v-row justify="center" style="height: 100%">
        <v-col
          cols="12"
          class="d-flex align-center flex-column justify-space-between py-1 px-3"
        >
          <h2 class="mb-auto">
            {{ name.substring(0, 30) }}
            <span class="job-title">
              <sup> ({{ bookCount }}) </sup>
            </span>
          </h2>
          <span class="job-title">{{ countryName }} - {{ birthYear }} </span>
        </v-col>
      </v-row>
    </div>
  </div>
  <!-- end box wrapper -->
</template>

<script>
export default {
  name: "AuthorCard",
  props: {
    name: {
      type: String,
      required: true,
    },
    image: {
      type: String,
      required: true,
    },
    countryName: {
      type: String,
      required: true,
    },
    birthYear: {
      type: String,
      required: true,
    },
    bookCount: {
      type: Number,
      required: true,
    },
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
<style scoped src="@/assets/css/authorcard.css"></style>
