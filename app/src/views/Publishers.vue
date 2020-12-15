<template>
  <section style="height: 100%" class="px-8">
    <v-container>
      <circular-progress v-if="!getPublishers" />
      <h1 class="google-sans-regular pl-6 mb-0 text-center">Publishers</h1>
      <v-divider class="my-4 mb-6"></v-divider>
      <v-row justify="center">
        <v-col
          cols="12"
          sm="6"
          md="4"
          lg="3"
          xl="2"
          v-for="publisher in getPublishers"
          :key="publisher.id"
          align="center"
        >
          <publisher-card
            :name="publisher.name"
            :foundationYear="publisher.foundationYear"
            :image="publisher.image"
            :description="publisher.description"
          />
        </v-col>
      </v-row>
    </v-container>
  </section>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import CircularProgress from "../components/CircularProgress.vue";
import PublisherCard from "../components/PublisherCard.vue";
export default {
  components: { CircularProgress, PublisherCard },
  name: "Publisher",
  methods: {
    ...mapActions("publisher", ["bindPublishers"]),
  },
  computed: {
    ...mapGetters("publisher", ["getPublishers"]),
  },
  async mounted() {
    await this.bindPublishers();
  },
};
</script>

<style>
</style>