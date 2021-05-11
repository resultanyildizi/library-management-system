<template>
  <section style="height: 100%" class="px-8">
    <circular-progress v-if="loading" />
    <v-container v-else>
      <h1 class="mb-2">
        {{ getPublisher.name }} - ( {{ getPublisher.foundationYear }} )
      </h1>
      <h4><i>Description</i></h4>
      <div class="google-sans-regular font-italic">
        {{ getPublisher.description ? getPublisher.description : "..." }}
      </div>
      <v-divider class="my-4 mb-6"></v-divider>
      <h1 class="text-center">📔 Books 📔</h1>
      <book-list :bookInfos="getBookInfosByPublisher" :updateable="false" />
    </v-container>
  </section>
</template>

<script>
import { mapActions, mapGetters } from "vuex";
import BookList from "../components/Book/BookList.vue";
import CircularProgress from "../components/Core/CircularProgress.vue";
export default {
  name: "Publisher",
  components: { BookList, CircularProgress },
  data() {
    return {
      loading: false,
    };
  },

  methods: {
    ...mapActions("book", ["bindBookInfos"]),
  },
  computed: {
    ...mapGetters("publisher", ["getPublisher"]),
    ...mapGetters("book", ["getBookInfosByPublisher"]),
    getImage() {
      try {
        return require(`@/assets/upload/img/${this.getPublisher.image}`);
      } catch (err) {
        return require("@/assets/upload/img/book/default_book_cover.jpg");
      }
    },
  },
  async mounted() {
    this.loading = true;
    console.log(this.getPublisher);
    await this.bindBookInfos({
      publisherId: this.getPublisher.publisherId,
    });
    this.loading = false;
  },
};
</script>

<style>
</style>