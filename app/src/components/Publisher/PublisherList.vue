<template>
  <section>
    <v-row justify="center">
      <v-col
        cols="12"
        sm="6"
        md="4"
        lg="3"
        xl="2"
        v-for="publisher in publishers"
        :key="publisher.id"
        align="center"
      >
        <publisher-card
          :name="publisher.name"
          :foundationYear="publisher.foundationYear"
          :image="publisher.image"
          :description="publisher.description"
          :bookCount="publisher.bookCount"
        />
      </v-col>
    </v-row>
  </section>
</template>

<script>
import PublisherCard from "@/components/Publisher/PublisherCard.vue";
export default {
  name: "PublisherList",
  components: {
    PublisherCard,
  },
  props: {
    publishers: {
      type: Array,
      required: true,
    },
  },
};
</script>

<style>
</style>