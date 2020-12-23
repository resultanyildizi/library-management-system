<template>
  <v-hover v-slot="{ hover }">
    <div class="card">
      <v-btn v-if="hover" class="deleteBtn" icon @click="openDeleteDialog">
        <v-icon color="primary"> mdi-delete </v-icon>
      </v-btn>
      <div class="card-image">
        <img :src="getImage" alt="profile-one" />
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
                <sup> ({{ publisher.bookCount }}) </sup>
              </span>
            </h2>
            <span class="job-title">{{ publisher.foundationYear }} </span>
          </v-col>
        </v-row>
      </div>
    </div>
  </v-hover>
</template>

<script>
export default {
  name: "PublisherCard",
  props: {
    publisher: {
      type: Object,
      required: true,
    },
  },

  methods: {
    openDeleteDialog() {
      this.$emit("openDeleteDialog", {
        name: this.publisher.name,
        publisherId: this.publisher.publisherId,
      });
    },
  },

  computed: {
    getFitName() {
      return this.publisher.name.length > 30
        ? `${this.publisher.name.substring(0, 27)}...`
        : this.publisher.name;
    },

    getImage() {
      try {
        return require(`@/assets/upload/img/${this.publisher.image}`);
      } catch (err) {
        return require("@/assets/upload/img/publisher/default_publisher.jpg");
      }
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
