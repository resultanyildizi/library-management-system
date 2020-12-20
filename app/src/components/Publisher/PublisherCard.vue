<template>
  <div class="card">
    <div class="card-image">
      <img :src="require(`../../../upload/img/${image}`)" alt="profile one" />
    </div>

    <div class="details">
      <v-row justify="center" style="height: 100%">
        <v-col
          cols="12"
          class="d-flex align-center flex-column justify-space-between py-1 px-4"
        >
          <h2 class="mb-auto">
            {{ getFitName }}
            <span class="job-title">
              <sup> ({{ bookCount }}) </sup>
            </span>
          </h2>
          <span class="job-title">{{ foundationYear }} </span>
        </v-col>
      </v-row>
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
    bookCount: {
      type: Number,
      required: true,
    },
  },

  computed: {
    getFitName() {
      return this.name.length > 30
        ? `${this.name.substring(0, 27)}...`
        : this.name;
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
